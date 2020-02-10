# Recipes

### Description

I have followed VIP design pattern to separate the dependencies of UIViewController into view, interactor and presenter. The View send event or messages to interactor. The Interactor receives the event/message and talks to model or service layer of the app and applies the business logic. It then sends the data if any to Presenter to present it on the view. The presenter massages the data and passes it to the View to display on the UI. The flow here is unidirectional.

The app is implemented in dark mode.

<img width="684" alt="Screenshot 2019-11-01 at 17 01 26" src="https://user-images.githubusercontent.com/6704803/68039120-b82c9180-fccb-11e9-99fc-0aaf7d34e75a.png">

Below is the dependency diagram to understand the flow of the app better:

<img width="684" alt="Screenshot 2019-11-01 at 16 51 00" src="https://user-images.githubusercontent.com/6704803/68039173-d98d7d80-fccb-11e9-9016-0c970947b75c.png">


Also, please find the screenshots of the app hereby: 

<img width="339" alt="Screenshot 2019-11-01 at 17 22 28" src="https://user-images.githubusercontent.com/6704803/68039550-a7c8e680-fccc-11e9-8f36-8970eefa4cac.png">   <img width="338" alt="Screenshot 2019-11-01 at 17 24 43" src="https://user-images.githubusercontent.com/6704803/68039646-dcd53900-fccc-11e9-952a-656dea2428f5.png">

### External Dependencies
- Contentful

 
