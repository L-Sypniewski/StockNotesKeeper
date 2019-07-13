import 'package:flutter_web/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            onSaved: (text) => debugPrint("On field saved 1"),
          ),
          TextFormField(
            onSaved: (text) => debugPrint("On field saved 2"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                 _formKey.currentState.save();
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
