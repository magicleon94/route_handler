import 'package:flutter/material.dart';
import 'package:route_handler/route_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings, context),
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Query param example"),
              onPressed: () => Navigator.of(context)
                  .pushNamed(Routes.queryParam + '?id=1&name=foo&surname=bar'),
            ),
            ElevatedButton(
              child: Text("Route param example"),
              onPressed: () => Navigator.of(context).pushNamed(
                Routes.routeParam,
                arguments: RouteParameter('1', 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QueryParamPage extends StatelessWidget {
  final Map<String, String> queryParams;

  const QueryParamPage({Key key, this.queryParams}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Query params page'),
      ),
      body: Center(
        child: Text(
          queryParams.toString(),
        ),
      ),
    );
  }
}

class RouteParameterPage extends StatelessWidget {
  final RouteParameter parameter;

  const RouteParameterPage({Key key, this.parameter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route parameter page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('String value: ${parameter.stringValue}'),
            Text('Int value: ${parameter.intValue}'),
          ],
        ),
      ),
    );
  }
}

class Routes {
  static const root = '/';
  static const queryParam = '$root/queryParam';
  static const routeParam = '$root/routeParam';

  static Route onGenerateRoute(RouteSettings settings, [BuildContext context]) {
    var route = settings.name.split('?').first;

    switch (route) {
      case queryParam:
        return QueryParamHandler(settings).getRoute(context);
      case routeParam:
        final parameter = settings.arguments as RouteParameter;
        return RouteParamHandler(settings, parameter).getRoute(context);
      case root:
      default:
        return RootHandler(settings).getRoute(context);
    }
  }
}

class RootHandler extends RouteHandler {
  RootHandler(RouteSettings settings) : super(settings);

  @override
  Route getRoute(BuildContext context) {
    return MaterialPageRoute(builder: (_) => RootPage());
  }
}

class QueryParamHandler extends RouteHandler {
  QueryParamHandler(RouteSettings settings) : super(settings);

  @override
  Route getRoute(BuildContext context) {
    return MaterialPageRoute(
      builder: (_) => QueryParamPage(
        queryParams: queryParameters,
      ),
    );
  }
}

class RouteParamHandler extends RouteHandler<RouteParameter> {
  RouteParamHandler(RouteSettings settings, RouteParameter extra)
      : super(
          settings,
          arguments: extra,
        );

  @override
  Route getRoute(BuildContext context) {
    return MaterialPageRoute(
      builder: (_) => RouteParameterPage(
        parameter: arguments,
      ),
    );
  }
}

class RouteParameter {
  final String stringValue;
  final int intValue;

  RouteParameter(this.stringValue, this.intValue);
}
