Demo App - Amplitude iOS SDK with Google Tag Manager
================

GTM integration on iOS requires installing our [native SDK](https://github.com/amplitude/amplitude-ios#setup), and then setting up GTM to trigger SDK functions via a custom function handler class that bridges GTM and our native SDKs. This demo apps is a proof of concept, with just the 3 most important functionalities implemented (logging events, setting user Id, and setting user properties) in the AmplitudeGTMHandler class. Here is our GTM setup:

User-Defined Variables (all Data Layer Variables):
* eventProperties
* eventType
* userId
* userProperties

Triggers
* logEvent: Event equals 'logEvent'
* setUserId: Event equals 'setUserId'
* setUserProperties: Event equals 'setUserProperties'

Tags:
logEvent
    * type: Function Call
    * Function Name: logEvent
    * Fire on trigger: Event equals 'logEvent'
    * arguments: eventType = {{eventType}}, eventProperties = {{eventProperties}}

setUserId
    * type: Function Call
    * Function Name: setUserId
    * Fire on trigger: Event equals 'setUserId'
    * arguments: userId = {{userId}}

setUserProperties
    * type: Function Call
    * Function Name: setUserProperties
    * Fire on trigger: Event equals 'setUserProperties'
    * arguments: userProperties = {{userProperties}}

The idea is that when you want to log an event, you push a "logEvent" event to the data layer with the variables for eventType and eventProperties -> activates the logEvent trigger -> activates the logEvent tag -> calls the function logEvent in the AmplitudeGTMHandler -> calls our SDK's logEvent.

GTM iOS Demo: https://github.com/amplitude/GTM-iOS-Demo
* AmplitudeGTMHandler: https://github.com/amplitude/GTM-iOS-Demo/blob/master/m2048/AmplitudeGTMHandler.m
* Setting up the handlers: https://github.com/amplitude/GTM-iOS-Demo/blob/master/m2048/M2AppDelegate.m#L20-L34
* Example of setting userId and userProperties: https://github.com/amplitude/GTM-iOS-Demo/blob/master/m2048/Controller/M2ViewController.m#L40-L43
* Example of logging an event: https://github.com/amplitude/GTM-iOS-Demo/blob/master/m2048/State/M2GameManager.m#L208-L209

A lot of the other functionality from the SDK hasn't been implemented (such as logging revenue, user property operations, etc), but this proof of concept demonstrates that GTM integration with Amplitude is possible, and events are being logged with the correct user Ids. Implementing the other functionalities would follow a similar pattern.