# route_handler

A simple abstraction that provides a structured guideline for named route handling in Flutter.

It supports query parameters for url-like behaviors and, via the ~~`routeExtra`~~ `arguments` property it is possible to provider more complex objects to the route.

If `arguments` not provided, it defaults to the `RouteSettings` `argument` property value.

## Usage

Just `extend` the `RouteHandler` class and implement its `getRoute` method.

Check out the example!


