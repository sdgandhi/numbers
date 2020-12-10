#  Numbers

> iOS app to practice number phrases

The Numbers app shows a series of numbers as numerals on the screen and asks you to speak numeral phrase for them.

For example:

1. **3824** would be shown on the screen.
1. You must say "Three thousand eight twenty four" to pass the round.

Numbers uses Siri voice recognition to verify if you have said the number correctly. This may cause your spoken phrase to be sent to Apple's servers to be evaluated. 
The Numers app does not store this information, and it is deleted from Apple's servers after the phrase has been evaluated.


## iOS Testflight beta

1. `sudo bundle update`
1. `bundle exec fastlane beta`

## Analytics

We're using Google Analytics, but not tracking any personal information. We only use these analytics to understand basic things like how many times the app is opened, how many games are being played, if any errors are happening.

Google analytics is integrated via Swift Package Manager. [Instructions](https://github.com/firebase/firebase-ios-sdk/blob/master/SwiftPackageManager.md).
