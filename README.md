An iOS App to help you become a real life deep fake

Created for CSC 471: Mobile Application Development for iOS at Depaul

Reed Klaeser CSC 471 Final Project Description and Documentation

App Name: Impressions
App Vision: If you’ve ever used the Guitar Tabs app, I imagine Impressions to be quite similar. Impressions helps you study impersonations via the Campaign screen, play around with randomized scenarios using the Play screen, and engage in a social element by sharing your Impersonations via the Social screen. I had also imagined a way in which you can compete with your impersonations but wasn’t able to build that into the App.

Features
-	Tab Bar Navigation
-	Home screen
-	Tutorial screens with audio switching for each tutorial page
-	Account screen with profile picture functionality, generation filter for the campaign screen, and achievement counts of Impressions and Games completed (Uncompleted: Political filters, accurate Tutorial achievement, editable Account info)
-	Campaign screen with campaign detail views and ability to mark the characters complete when you’ve mastered them.
-	Play screen with shuffled characters and scenes you can act out
-	Share videos of impressions via a to a feed (partially complete)

Reed Klaeser CSC 471 Final Project Discussion

API Features
I used AVKit, TipKit, and though it is not an API, SwiftUI in conjunction with UIKit to build my app. AVKit is used to show a VideoPlayer on the Social view and to request camera access for the profile picture in the Account view. TipKit is used to give a Tip on the Play screen. TipKit only exists in SwiftUI and figuring out how to fit it in my app exposed me to SwiftUI and the idea of integrating it within a UIKit app. It is worth mentioning the camera access that required AVKit also required making a PList change to the App. 

Challenges
The hardest part of this project was routing and sharing data between views. 

Routing
Context switching between manual storyboard changes and programmatic view controller changes was difficult for me throughout this class and my introduction of SwiftUI into the project added further complexity. I’ll list the types of routing that occur in the app and where: launching a SwiftUI view from a UIKit View Controller using a generic container (VC_Home -> V_Tutorial, V_Account) and a specific container (tab view controller -> V_Play, V_Social), launching a UIKit View Controller from a SwiftUI View, and the nominal cases of UIKit View Controller to UIKit ViewController, and SwiftUI View to Swift UI View. The naming convention is VC_ for View Controllers, V_ for SwiftUi Views, and M_ for data models. Each of these routings is done via a modal, using UIStoryBoard to grab the View Controller in the case of UIKit, and a UIViewControllerRepresentable to wrap the SwiftUIView in the case of SwiftUI. Part of the difficulty was discovering how to implement these routings and the other part was the accumulated costs of having to build mostly functionless wrapper objects.

Sharing Data
I implemented data sharing several ways and could admittedly use more experience before saying which was best. Those ways were: Classes (M_Tutorial), Singelton Classes (GenerationFilterManager, SharedImage), Constant Variables holding Classes (M_Impression), and Variables holding Structs (M_Social, M_Scenario). Singeltons, Constant Variables, and Structs all created safety by constraining how the data could exist or be manipulated but I think there ended up being little difference between for instance the constant variable holding classes and the singleton classes. Because SwiftUI is a declarative framework (“make it look like this”) there must be something to tell the views when to update given a data change. The state keyword is used when the data exists on a single view. The ObservedObject is used when it exists across Views. The Singelton Classes I used also implemented the ObservedObject protocol so that the data could be shared between Views and View Controllers. These Observed Objects observe changes in the Published Variables within their classes. For the Shared Image I ended up having to set a dummy variable imageExists to trigger the V_Account view to update. I think it had to do with the complexity of determining whether an image object changed versus the straightforward nature of determining that a boolean Boolean value changed. I also added videos and audio to the app bundle that I used in the Tutorial and Social views. I got stuck on the file extensions being case sensitive before eventually figuring it out.


App Limitations
The App has inconsistent styling between SwiftUI and UIKit views, for instance the back button in SwiftUI is part of a navigation view whereas it is a constrained button in the UIKit views. The SwiftUI layout is also not the same between my phone which I buit the app to during development and the simulator. On the simulator the scenarios on the Play screen flow off the page but on my iPhone 12 Mini they properly wrap. The App is still usable in portrait mode but not always fully functional, see campaign detail and the below the fold Tip on Play. A key feature I had hoped to develop was recording videos of impressions to post in the social page of the app but I was unable to turn my proof of concept picture taking page into a video recording page. I pivoted and used the picture taking feature to replace set a profile picture. On the first scroll through of the Tutorial Trump is pushy and tries to talk over Obama, after that and on back scrolls he waits his turn. I was unable to successfully debug this behavior.

iOS Limitations
Most IOS Apps and most IOS App Development today takes place in UIKit and since most organizations take a piecemeal approach to advancing their tech stack it is not very likely that entire apps will be rewritten in SwiftUI. Because of this I was curious to see how flexibly an App could switch between the two. The biggest limitation I found was that UIKit and SwiftUI both contain subsets of the total iOS feature sets so you’re not free to choose whichever framework fits the situation. For instance, TipKit only exists in SwiftUI and UIImagePickerController  and an iOS 14 alternative PHPickerViewController  only exist in UIKit and require wrapping in a UIViewControllerRepresentable to be used with a SwiftUI view. This required me to build a SwiftUI view to house the TipKit and kick out to a mostly blank view controller to manage the camera. Perhaps, by composing views with both UIKit and SwiftUI I could have put more of the app in a single framework and reduced these switching frictions.

My Experience as an iOS Developer
After using Xcode I’ve come to think that a GUI that obfuscates code and configuration changes decreases the developer experience. I probably sound like one of those crazies that still use VIM so let me clarify. I like to use frequent Git commits as a debugging tool which requires me to mentally connect a change I made in the IDE to the change I see in a file before I commit. This was difficult for me as a new developer using Xcode because there were so many additional project files whose purpose I did not understand and because it wasn’t always easy to connect changes I had made in the GUI to changes that appeared in the files. More often I was left feeling that something magical was happening than that something determinant had happened even though it was all determinant.  I also found Xcode errors and stack traces maddeningly difficult to attribute to lines of code. This is night and day with my experience in Visual Studio where I found myself able to quickly recognize and fix errors. For instance, a PList change I made via the Open As source code option to directly edit the XML ended up giving me a STGABORTT without any helpful debugging information. To reduce the risk of getting stuck with an unknown error I found I had to make and test smaller changes and overall take a more piecemeal approach to development. For instance, I didn’t dare attempt to build video recording functionality in a single step, instead I started with photo functionality and attempted to build up. The overall affect was I felt less productive. 


![image](https://github.com/rklaeser/Impressions-App/assets/30515573/b606fbaa-537b-4d1c-8528-d8fd93e21fcf)
