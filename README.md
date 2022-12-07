![TokTok logo](docs/assets/logo.png)

# TokTok

**TokTok** was made for a Take Home Test for Avantsoft.

The premise is simple: the application is inspired by TikTok, with a feed of videos that the user can watch by scrolling vertically on the screen and react to them.
There are 2 possible reactions — **Heart** and **Fire** — and they can both be used multiple times!

_It's not TikTok, don't sue me lol_

### 🛠 Pre-requisites

TokTok was developed with iOS 13 in mind, so you need at least Xcode 11 to run it. There's also no external package managers in the project, so you don't need CocoaPods nor Carthage to run it.

Just download the project and run as is on a simulator or sign it and run on a device.

### 🛠 Project structure

This project is a demo, with an API that was provided for the project. It saves interactions locally only, so your hearts and fires won't persist through sessions.

MVVM was chosen as an architectural pattern, considering time available and ease of implementation. Some extra work was done to the Networking layer, making it flexible and easy to switch between mocked data and real data retrieved from the API. As for the UI, UIKit is being used, considering what's been talked about the job beforehand; however, it was used with caution -- with view-code when possible, and with extra care put into @IBDesignable components when the Interface Builder is used, for example.

SwiftUI is something that I highly encourage, though, especially considering how much it matured in the last few years and all the advantages that comes with it -- less problematic with version control, higher productivity with Apple's new components and the ease of development for a in-house Design System, etc.

## 👨‍🏫 Self-critique

### 🧑‍💻 Remaining development

Unfortunately, as of now, some parts of the application couldn't be developed in time:
- Pagination wasn't implemented, so the application is fetching 100 items and showing them all;
- Unit and UI tests weren't implemented.

### 👨‍🎨 UI/UX

Custom resources weren't on this phase of the project.
System defaults were used for icons and fonts, and the logo is just TikTok's logo flipped upside-down.

### 👩‍🚀 Next steps

First of all, whatever remains from the original scope should be developed.
But then...

- Fail states;
- New micro-animations (probably using Lottie);
- Different environment configurations;
- Automations for testing and deployment;
- ...and a whole lot more!