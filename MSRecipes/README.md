# Recipes

### Description

Dear reviewers, thank you for taking the time to review my code.

I have followed VIP design pattern to separate the dependencies of UIViewController into view, interactor and presenter. The View send event or messages to interactor. The Interactor receives the event/message and talks to model or service layer of the app and applies the business logic. It then sends the data if any to Presenter to present it on the view. The presenter massages the data and passes it to the View to display on the UI. The flow here is unidirectional.

 ### Dependencies
- Contentful
