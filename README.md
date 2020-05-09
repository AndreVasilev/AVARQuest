# AVARQuest

The app is designed to create an AR quest at home

## Prepartion

1. Take a photo of the appropriate places in the apartment where the map pieces will be "hidden"
2. Trim the photos, add them to the folder *Assets->AR Resources* and specify the actual size
3. Take a photo of the gift
4. Replace reference image at *Assets->AR Gift->ar-gift*
5. Draw a map of your house and slice it for map items. Add items to *Assets->MapItems*
6. Draw some certificate and replace the template at *Assets->gift-tracked*
7. Create your model at *Models->MapItem*
6. Set your model at *ImageDetectionAssembly* line 19 
8. Install the app
9. Run the app and setup date, title and text of the notification
10. Wait

## Usage

1. Receive a notification
2. Open the App
3. Look around in search of the "hidden" map items
4. Collect all the items and open the map
5. Look at the map and find your gift
6. Tap 🎁 at the map
7. Scan your gift to find a certificate too
8. Have fun! 🙂


## Limitation

The map's layout is adopted for iPhone X with 4 map's items columns.
If you want to adopt it to another screen size or columns count, you should to change cell size of collectionView at *Main.storyboard->MapViewController*.
Or write some code 😉

## Credentials

[Detecting Images in an AR Experience](https://developer.apple.com/documentation/arkit/detecting_images_in_an_ar_experience)
