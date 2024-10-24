# food_tracker

A minimalistic mobile App for tracking your daily eating behaviour.

Todo:

- bugfixes and code refactorings
- create a respectable UI
- add possibility to provide recipes
- create theme based on android colors

## Debugging the App

- in VS code open Simulator or Android Emulator and press F5 (in a Dart File)

## Building for production

- Android:
  - change version number in android/app/build.gradle and pubspec.yaml
  - run `flutter clean`
  - run `flutter build apk --split-per-abi`

## Changing the App Icons

- change properties in flutter_launcher_icons.yaml (documentation [here](https://pub.dev/packages/flutter_launcher_icons))
- run `dart run flutter_launcher_icons`

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
