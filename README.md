# Blitz News
### A beautiful and minimalistic iOS news reader built with Swift 3

![](http://imgur.com/fbubHow)![](http://imgur.com/eQFytlU)![](http://imgur.com/ysAygQG)


#### Description
Blitz News is a minimal news reader app that leverages the [news api](newsapi.org) to aggregate news from multiple news sources. The user can select their preferred news sources and view the latest news articles for those sources. Developed using Swift 3.

#### Development Notes

The app utlises the following frameworks and development methodologies:  

* Core Data
Core data is used for storing the user's preferences on disk storage on the phone. 

* [Swifty JSON](https://github.com/SwiftyJSON/SwiftyJSON)
Swifty JSON is used for efficient JSON parsing

* [Alamofire](https://github.com/Alamofire/Alamofire)
Alamofire is used for networking and making API calls to the News API

* OOP in View Controllers
Use of OOP to move generic functionality into parent view controllers. This makes the code easy to maintain and debug in child view controllers.

* Component Design
View controllers utilse static classes and helper classes for dealing with heavy UI code. This keeps view controller classes small.

* Unit and UI testing
XCTestCases for testing out core functionality of the classes and UI automation testing
