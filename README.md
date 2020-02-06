# my_events

An example Flutter app that uses Firebase as a back-end.

## Steps to reproduce

Attempts have been made to have the [commits](https://github.com/jifalops/my_events/commits/master)
work as steps for creating the app, although those are in reverse order.
Here's an outline.

1. [Install flutter](https://flutter.dev/docs/get-started/install).
2. Run the command `flutter create my_events`.
3. Create the
[`Profile`](https://github.com/jifalops/my_events/blob/master/lib/models/profiles.dart#L8) and
[`Event`](https://github.com/jifalops/my_events/blob/master/lib/models/events.dart#L8) models, and the serialization logic for doing Object to/from String conversions. See the ~fourth commit for details, also this [example](https://github.com/dart-lang/json_serializable/tree/master/example).
4. Setup Firebase to serve as the backend.
   1. [Create a Firebase project](https://console.firebase.google.com/). Adding analytics is optional.
   2. After the project is created click on the Android icon on the project's home page to setup an Android app.
   3. The default package name for this project is `com.example.my_events`.
   4. Click on the question mark to get instructions for creating a debug signing certificate. This is required since We'll be using Google Sign-In.
      > Enter the `SHA1` key you generated in your terminal into the web form.
   5. You should now be able to download a file named `google-services.json`. Place it in the `my_events/android/app/` directory.
   6. Follow the instructions for making changes to `my_events/android/build.gradle` and `my_events/android/app/build.gradle`.
   7. In the Firebase web console for your project, click `Authentication` in the left navigation area and then click the `Sign-in method` tab. Enable `Google` as a sign-in method and save.
   8. Click `Database` in the left nav area and scroll down to enable the `Realtime Database`. Start in **test mode**, allowing all reads and writes. Security rules are outside the scope of this project. While the realtime database doesn't scale as well as the Firestore database, it can be easier to work with and also lets the app know if it is currently connected.
   9. Declare `firebase_auth`, `google_sign_in`, and `firebase_database` as dependencies in `pubspec.yaml`.
5. Test Google sign-in by modifying `main.dart` and creating `lib/controllers/auth_controller.dart` with the contents from [this commit](https://github.com/jifalops/my_events/commit/4189784515e8c1e181448b8b73f99115526704fe).
6. Show a different UI when the user is signed in. [[commit](https://github.com/jifalops/my_events/commit/f8d992c5478e0666c77754f5075bd3e32357d890)]
7. Add the event form to the home screen. [[commit](https://github.com/jifalops/my_events/commit/416f4ee2cbaf7adccc57e51438aaed2464aecf06)]
8. [Add some helpers](https://github.com/jifalops/my_events/commit/ae2db209713b7a70880aeb19500d6f57f856e247) and [do some prep](https://github.com/jifalops/my_events/commit/f0b8b2d9d14be37af28caa4c442ebe802f8d9724) to [make the 'Create event' button work](https://github.com/jifalops/my_events/commit/902e7b662d8d54a60eb2ae32bc466e03eee9fd66).
9. Do all the things. 🤷