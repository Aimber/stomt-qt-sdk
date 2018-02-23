# STOMT stomt-qt-sdk [![STOMT API](https://img.shields.io/badge/stomt-v2.10.X-brightgreen.png)](https://rest.stomt.com/)[![Build status](https://ci.appveyor.com/api/projects/status/dv4pqwy8b87k1l0p?svg=true)](https://ci.appveyor.com/project/kelteseth/stomt-qt-sdk)


This is an unofficial Qt/QML integration. [Give us (anonymous) feedback via stomtQtSDK @stomt!](https://www.stomt.com/stomtqtsdk)

<p align="center">
  <a href="https://www.stomt.com/stomtqtsdk">
    <img alt="STOMT Qt/QML feedback integration" src="https://i.imgur.com/h1GBFLg.png" />
  </a>
</p>

## Why?

STOMT allows you to collect simple and constructive feedback in-game and [also from your website](https://stomt.co/web) and collect it at one central place where you manage it and where your community can vote and comment on the feedback of others. (see [use cases](#use-cases) below)

## Requirements
* Minimum Qt version: Qt 5.7
* Tested Qt version: Qt 5.10.1
* Latest OpenSSL which is not available in the official Qt installer. Therefore I recommend using Qt via [msys2](http://www.msys2.org/) where you have all the packages you need to develop with theses three commands:

 - Start msys2
    - Run: ``` pacman -Syu ``` then restart terminal
    - Run: ``` pacman -Su ```
    - Run: ``` pacman -S  mingw64/mingw-w64-x86_64-gdb mingw64/mingw-w64-x86_64-qt5 mingw64/mingw-w64-x86_64-qt-creator  mingw64/mingw-w64-x86_64-gcc mingw64/mingw-w64-x86_64-openssl ```
## Installation

1. Clone this repository
2. Open the stomt-qt-sdk.pro in QtCreator
3. Add install to the build steps. Projects -> Build -> Add Build Step -> Select Make -> Insert "install" into Make arguments
4. Press build. This will compile the project and copy all necessary files into your Qt installation 
 * Example Path: C:\msys64\mingw64\share\qt5\qml\com\stomt\qmlSDK\
 
 ## Usage
```qml
import com.stomt.qmlSDK 1.0

    StomtWidget {
        targetID: "screenplay"
        appKey: "YourAppID"
        targetDisplayName: "ScreenPlay"
        targetImageUrl: "qrc:/assets/icons/favicon.ico"
    }
    
```
## Use our Sandbox

If you want to test the integration please feel free to do what you want on [test.stomt.com](https://test.stomt.com/)

* Just go through the configuration steps again using the test server:

1. Register on [test.stomt.com](https://test.stomt.com/signup/game).
2. And create an [App Id](https://test.stomt.com/integrate) for your project.
3. Add this to your StomtWidget {...}

```qml
        useTestServer: true
```

## Contribution

We would love to see you contributing to this project. Feel free to fork it and send in your pull requests! Visit the [project on STOMT](https://www.stomt.com/stomtqtsdk) to support with your ideas, wishes and feedback.


## Authors

[Elias Steurer](https://github.com/kelteseth) | [Follow me on STOMT](https://www.stomt.com/kelteseth)


## More about stomt

* On the web [www.stomt.com](https://www.stomt.com)
* [STOMT for iOS](http://stomt.co/ios)
* [STOMT for Android](http://stomt.co/android)
* [STOMT for Unity](http://stomt.co/unity)
* [STOMT for Websites](http://stomt.co/web)
* [STOMT for Wordpress](http://stomt.co/wordpress)
* [STOMT for Drupal](http://stomt.co/drupal)
