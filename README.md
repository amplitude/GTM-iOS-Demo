Amplitude iOS Demo
================

A simple 2048 derivative. See [the original](https://github.com/gabrielecirulli/2048) or the fantastic [version](https://github.com/danqing/2048) built by Danqing Liu that this demo is based on.

The Amplitude integration contains these parts:

* Add the Amplitude SDK using CocoaPods. See ```Podfile```.
* Amplitude initialization in ```application:didFinishLaunchingWithOptions```.
* Setting user properties and logging events with properties in ```M2GameManager```.
* Tracking Push Notifications and Push Notification actions in ```AppDelegate```.
