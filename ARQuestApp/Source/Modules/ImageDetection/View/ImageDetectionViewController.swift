//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import AudioToolbox

final class ImageDetectionViewController: BaseViewController {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var mapButton: UIButton!

    var presenter: IImageDetectionPresenter!

    /// The view controller that displays the status and "restart experience" UI.
    lazy var statusViewController: StatusViewController = {
        return children.lazy.compactMap({ $0 as? StatusViewController }).first!
    }()

    /// A serial queue for thread safety when modifying the SceneKit node graph.
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    var isRestartAvailable = true

    init(presenter: IImageDetectionPresenter) {
        self.presenter = presenter
        super.init(output: presenter)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true
        resetTracking()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
        statusViewController.cancelAllScheduledMessages()
        sceneView.session.pause()
    }

    override func didMove(toParent parent: UIViewController?) {
        resetTracking()
    }
}

private extension ImageDetectionViewController {

    func configure() {

        sceneView.delegate = self
        sceneView.session.delegate = self

        // Hook up status view controller callback(s).
        statusViewController.restartExperienceHandler = { [unowned self] in
            self.restartExperience()
        }
    }

    func resetTracking() {

        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: presenter.resourceGroupName, bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }

        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

//        statusViewController.scheduleMessage("Look around to detect images", inSeconds: 7.5, messageType: .contentPlacement)
        statusViewController.scheduleMessage("Смотри вокруг в поиске спрятанных предметов", inSeconds: 7.5, messageType: .contentPlacement)
    }

    func displayErrorMessage(title: String, message: String) {
        blurView.isHidden = false

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
        let restartAction = UIAlertAction(title: "Перезагрузить", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            self.blurView.isHidden = true
            self.resetTracking()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }

    func restartExperience() {
        guard isRestartAvailable else { return }
        isRestartAvailable = false
        statusViewController.cancelAllScheduledMessages()
        resetTracking()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.isRestartAvailable = true
        }
    }

    func imageNode(named name: String, referenceImage: ARReferenceImage) -> SCNNode {
        let plane = SCNPlane(width: referenceImage.physicalSize.width,
                             height: referenceImage.physicalSize.height)
        let planeNode = SCNNode(geometry: plane)
        planeNode.opacity = 1
        planeNode.eulerAngles.x = -.pi / 2
        let image = UIImage(named: name)
        planeNode.geometry?.firstMaterial?.diffuse.contents = image
        return planeNode
    }

    @IBAction func presentMap() {
        presenter.presentMap()
    }

    func rendererDidAdd(node: SCNNode, for imageAnchor: ARImageAnchor) {
        if let referenceImageName = imageAnchor.referenceImage.name,
            let imageName = presenter.didTrackImage(referenceName: referenceImageName) {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            updateQueue.async { [weak self] in
                if let childNode = self?.imageNode(named: imageName, referenceImage: imageAnchor.referenceImage) {
                    node.addChildNode(childNode)
                }
            }
        }
    }
}

extension ImageDetectionViewController: IImageDetectionView {

}

extension ImageDetectionViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imageAnchor = anchor as? ARImageAnchor {
            DispatchQueue.main.async { [weak self] in
                self?.rendererDidAdd(node: node, for: imageAnchor)
            }
        }
    }
}

extension ImageDetectionViewController: ARSessionDelegate {

    // MARK: - ARSessionDelegate

    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        statusViewController.showTrackingQualityInfo(for: camera.trackingState, autoHide: true)

        switch camera.trackingState {
        case .notAvailable, .limited:
            statusViewController.escalateFeedback(for: camera.trackingState, inSeconds: 3.0)
        case .normal:
            statusViewController.cancelScheduledMessage(for: .trackingStateEscalation)
        }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }

        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]

        // Use `flatMap(_:)` to remove optional error messages.
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")

        DispatchQueue.main.async {
//            self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
            self.displayErrorMessage(title: "Что-то сломалось. Лучше перезапустить приложение", message: errorMessage)
        }
    }

    func sessionWasInterrupted(_ session: ARSession) {
        blurView.isHidden = false
//        statusViewController.showMessage("""
//        SESSION INTERRUPTED
//        The session will be reset after the interruption has ended.
//        """, autoHide: false)
        statusViewController.showMessage("""
        ПОИСК ПРЕРВАН
        Дождись автоматического перезапуска или перезапусти приложение.
        """, autoHide: false)
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        blurView.isHidden = true
        statusViewController.showMessage("ПЕРЕЗАГРУЗКА")//("RESETTING SESSION")

        restartExperience()
    }

    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return true
    }
}
