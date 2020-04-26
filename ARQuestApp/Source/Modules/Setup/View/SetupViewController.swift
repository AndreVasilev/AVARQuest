//
//  Created by Andrey Vasilev on 22/04/2020.
//  Copyright © 2020 Andrey Vasilev. All rights reserved.
//

import UIKit

final class SetupViewController: BaseViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    var presenter: ISetupPresenter!

    init(presenter: ISetupPresenter) {
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
}

private extension SetupViewController {

    func configure() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        makeConstraints()
    }

    func makeConstraints() {

    }

    @IBAction func setupNotification() {
        guard let title = titleTextField.text,
            let body = bodyTextField.text
            else { return }
        NotificationService.shared.addNotification(title: title, body: body, date: datePicker.date)
    }

    @IBAction func previewNotification() {
        guard let title = titleTextField.text,
            let body = bodyTextField.text
            else { return }
        NotificationService.shared.previewNotification(title: title, body: body)
    }

    @objc func endEditing() {
        view.endEditing(true)
    }
}

extension SetupViewController: ISetupView {

}
