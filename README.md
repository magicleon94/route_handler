# route_handler

A simple abstraction that provides a structured guideline for named route handling in Flutter.

This provides an easy abstraction to deal with named routes in a structured way. You can either access parameters passed in a URL fashioned way and/or use more complex objects.

For URL-like parameters just access the `queryParameters` getter provided by the abstraction.
For complex objects use the `routeExtra` property.

## Usage

Just `extend` the `RouteHandler` class and implement its `getRoute` method.

Check out the example!


