import 'package:flutter/widgets.dart';

/// [RouteHandler abstract class]
abstract class RouteHandler<T> {
  ///[settings] are the `RouteSettings` passed by the `onGenerateRoute` from `MaterialApp`
  final RouteSettings settings;
  Map<String, String> _queryParameters;

  ///[routeExtra] is an optional extra if a complex object needs to be passed to the route
  final T routeExtra;

  @mustCallSuper
  RouteHandler(this.settings, {this.routeExtra});

  /// Returns the generated route
  Route getRoute(BuildContext context);

  /// Parse the query parameters passed in the route name
  /// Example: routeName?id=1&name=foo will result in
  /// {'id': '1', 'name':'foo'}
  Map<String, String> get queryParameters {
    if (_queryParameters != null) {
      return _queryParameters;
    }

    final urlParts = settings.name.split('?');
    if (urlParts.length > 1) {
      final paramPart = urlParts[1];
      final params = <String, String>{};
      paramPart.split('&').forEach((p) {
        final split = p.split('=');
        final key = split[0];
        final value = split[1];
        params[key] = value;
      });
      _queryParameters = params;
    }

    _queryParameters ??= {};
    return _queryParameters;
  }
}
