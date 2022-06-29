#  ComicsApp

  This flutter web app does a pair of requests to the comics api https://comicvine.gamespot.com/api/

  In order to make the requests to work, I have set up a simple dart server. So please, make sure that you are in /comics_server folder
  for example, in a console, and run the following command before start the web app: 

   - dart run bin/comics_server.dart
  
  Then, in /comics_app run the following: 

   - flutter packages pub run build_runner build 

  If there is a port problem, just change to another in both:  lib/di/http_module.dart AND server/comic_server/bin/comics_server.dart


# Architecture

This web app was made with clean architecture, and make use of package like:

- flutter_bloc for state managment,
- Injectable for services locator
- Dio for http requests.


About the server: 

It is just a customization of the example that make a simple http dart server: https://github.com/dart-lang/samples/tree/master/server/simple



