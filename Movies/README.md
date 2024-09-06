# movies

## How to build?

Run script `build.sh` and then open generated `.xcworkspace` file.

## Used pods 

[Cocoapods-keys](https://github.com/orta/cocoapods-keys) -> for secure store of API_KEY. 

## About

Simple application for fetching currenlty played movies. There is also an option for searching a movie with autocompleting support. User can display details about movie and also mark some movies as favourites. 
Solution is written in Swift and Swift, based on MVVM architecture. For storing data is used UserDefaults because we only need to store a simple array of IDs so there is no need for usage of any database. 
App will run on iOS 15 and newer. 
