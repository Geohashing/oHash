# What versions of iOS should we support?

The latest iOS version at time of writing (late Jan 2024) is 17.x.
But of course not all users are on 17 yet.

## What versions do users use?

As of the end of November 2023,
[TelemetryDeck](https://telemetrydeck.com/blog/ios-market-share-13-23/) says iOS 17 only gives 63.2% of users, 16+ gives 96.2%, and 15+ gives 99.9%.

The [official Apple page](https://developer.apple.com/support/app-store/)
was last updated in May 2023, so is pretty much useless.

The data from Dec 2023 in [this Statcounter page](https://gs.statcounter.com/os-version-market-share/ios/mobile-tablet/worldwide)
says that 17+ reaches 54.5%, 16+ gives 85% and 15+ gives 94%

Also, a quick survey of exactly two Geohashers on
[this thread](https://discord.com/channels/742785009202626640/1200076111191752858)
in late Jan 2024 reported one 16.7.4 and one 17.2.1.

So from a "what do users use" viewpoint, we probs want to support 16 as well as 17. Going back to 15 would be lovely, but only if it's no extra effort.

## What versions give better functionality?

No idea. My plan is to start by supporting all the way back to iOS 15,
and see if that blocks me from using anything cool.

I can always change it to support only 16+ (or even 17+)  if I have to.
