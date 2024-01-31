# What versions of iOS should we support?

The latest iOS version at time of writing (late Jan 2024) is 17.x.
But of course not all users are on 17 yet.

## What versions do users use?

As of the end of November 2023,
[TelemetryDeck](https://telemetrydeck.com/blog/ios-market-share-13-23/) says iOS 17 only gives 63.2% of users, 16+ gives 96.2%, 15+ gives 99.9%, and 14+ gives 99.96%.

The [official Apple page](https://developer.apple.com/support/app-store/)
was last updated in May 2023, so is pretty much useless.

The data from Dec 2023 in [this Statcounter page](https://gs.statcounter.com/os-version-market-share/ios/mobile-tablet/worldwide)
says that 17+ reaches 54.5%, 16+ gives 85%, 15+ gives 94%, and 14+ gives 96%

Also, a quick survey of exactly three Geohashers on
[this thread](https://discord.com/channels/742785009202626640/1200076111191752858)
in late Jan 2024 reported one 16.3.1 (iPhone 8 so can't go higher), one 16.7.4 (didn't say why), and one 17.2.1.

So from a "what do users use" viewpoint, we probs want to support 16 as well as 17. Going back to 15 or even 14 would be lovely, but only if it's no extra effort.

## What versions give better functionality?

No idea. My plan is to start by supporting all the way back to iOS 14,
and see if that blocks me from using anything cool.

I can always change it to support only 15+, 16+, or even 17+ later on, if I have to.

## What functionality would be better in iOS 15, 16, or 17?

### Persistance

[SwiftData](https://developer.apple.com/documentation/swiftdata) is 17+. And SwiftData is cool. :-)

I can use [Core Data](https://developer.apple.com/documentation/coredata) instead but it's clunkier.
Or maybe I can just use [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults/),
if I'm not storing much data.

Could also use [SceneStorage](https://developer.apple.com/documentation/swiftui/scenestorage) to store scene state between runs of the app. So might not really miss SwiftData too much.

### Map Annotations

It'd be lovely to use [Annotations](https://developer.apple.com/documentation/mapkit/annotation) on the map, but they're 17+. I can use [MapKit annotations](https://developer.apple.com/documentation/mapkit/mapkit_for_appkit_and_uikit/mapkit_annotations) instead,
but they're clunkier.

### Linking data to views

It'd be nice to use the [Observable](https://developer.apple.com/documentation/Observation/Observable()) macro, but it's 17+.
For pre-17 I'd need to use [ObservableObjects](https://developer.apple.com/documentation/Combine/ObservableObject) which are usable 
but a bit more of a pain.

### Summary

All these things would be a bit cleaner and simpler if I only support
iOS 17+. But that cuts out a good number of potential users.

So if I'm not going to inisist on iOS 17, I might as well support all the way back to 14. There's nothing cool that I want to use that was new in 15 or 16.
