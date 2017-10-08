import 'package:flutter/material.dart';

const homeRoute = Navigator.defaultRouteName;
const secondRoute = 'route_two';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String nextRoute = homeRoute;

  void _nextRoute() {
    String route = secondRoute;
    if (nextRoute == secondRoute) route = homeRoute;
    setState(() {
      print('setting route to $route');
      nextRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routes = {
      homeRoute: (BuildContext context) => new MyHomePage(nextRoute: _nextRoute),
      secondRoute: (BuildContext context) => new _MySecondRoute(_nextRoute),
    };
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: nextRoute,
    );
  }

}

class MyHomePage extends StatefulWidget {
  final VoidCallback nextRoute;
  MyHomePage({Key key, this.nextRoute}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home Page'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'home page route',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
        new RaisedButton(
        onPressed: widget.nextRoute,
        child: new Text('Change Initial Route'),
      ),
        new RaisedButton(
          onPressed: () => Navigator.pushNamed(context, secondRoute),
          child: new Text('Push'),
        ),
      ]),
    );
  }
}

class _MySecondRoute extends StatelessWidget {
  final VoidCallback _fabAction;

  _MySecondRoute(this._fabAction);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second Route'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'I am another route',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _fabAction,
        tooltip: 'DoIt',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}