import 'package:flutter_web/material.dart';
import 'package:stock_notes/screens/login_screen.dart';
import 'package:stock_notes/widgets/RoundedButton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            LoginScreen(),
            Center(child: RoundedButton(title: "Log in")),
            SizedBox(
              height: 500,
              child: TextFormField(
                maxLines: 10,
                enableInteractiveSelection: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
