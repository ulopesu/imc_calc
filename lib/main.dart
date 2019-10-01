import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

  theme: ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColor: Colors.lightBlue[800],
    accentColor: Colors.cyan[600],
    
    // Define the default font family.
    fontFamily: 'Montserrat',
    
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  ),

  home: MyHomePage(title: 'My First Flutter App!!!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _imc = 22;
  double _height = 1.65;
  double _weight = 60;

  double _w1 = 0;
  double _w2 = 0;

  Color _alertColor = Colors.green;

  final myHeight = TextEditingController();
  final myWeight = TextEditingController();

  void _calculateIMC() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _height = double.parse(myHeight.text.trim())/100;
      _weight = double.parse(myWeight.text.trim());

      _imc = _weight / (pow(_height, 2));

      _w1 = 18.5 * (pow(_height, 2));
      _w2 = 24.9 * (pow(_height, 2));
      
      if(_imc <= 18.5 || _imc >= 30){
        _alertColor = Colors.red;
      } else if (_imc > 18.5 && _imc < 25) {
        _alertColor = Colors.green;
      } else {
        _alertColor = Colors.orange;
      }

      myHeight.clear();
      myWeight.clear();

    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('IMC - Calculator',
              style: TextStyle(fontSize: 40),
            ),

            TextField(
              controller: myHeight,
              keyboardType: TextInputType.numberWithOptions(signed: false),
              textAlign: TextAlign.center,
              decoration: new InputDecoration(
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                
                hintText: 'Enter your height in cm.',
              ),
              
            ),

            Text('\n'),

            TextField(
              controller: myWeight,
              keyboardType: TextInputType.numberWithOptions(signed: false),
              textAlign: TextAlign.center,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                hintText: 'Enter your weigth in Kg',
              ),
            ),

            Text(
              '\nYour IMC is:',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              _imc.toStringAsPrecision(3),
              style: TextStyle(color: _alertColor, fontSize: 40),
            ),

            Text(
              '\nYour weight ideal is:',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              _w1.toStringAsPrecision(3) + ' to '+ _w2.toStringAsPrecision(3) + ' Kg!',
              style: TextStyle(color: _alertColor, fontSize: 40),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calculateIMC,
        tooltip: 'Calculate',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
