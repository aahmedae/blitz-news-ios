# Blitz News
### A beautiful and minimalistic iOS news reader built with Swift 3

<p align = "center">
  <img src = "https://github.com/aahmedae/aahmedae.github.io/blob/master/images/screenshots/showcase.png" width = "400"> 
</p>

<p align = "center">
  <img src = "https://github.com/aahmedae/aahmedae.github.io/blob/master/images/screenshots/01.png" width = "400">  
</p>

<p align = "center">
  <img src = "https://github.com/aahmedae/aahmedae.github.io/blob/master/images/screenshots/02.png" width = "400">   
</p>

<p align = "center">
  <img src = "https://github.com/aahmedae/aahmedae.github.io/blob/master/images/screenshots/03.png" width = "400">  
</p>

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


<p align = "center">
  <a href = "https://itunes.apple.com/ae/app/blitz-news/id1244146527?mt=8"><img src = "https://github.com/aahmedae/aahmedae.github.io/blob/master/images/screenshots/other/app_store_download_badge.svg"></a>  
</p>
