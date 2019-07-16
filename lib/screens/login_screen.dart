import 'package:flutter_web/material.dart';
import 'package:stock_notes/widgets/RealTimeValidatedTextFormField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          RealTimeValidatedTextFormField(
            formState: _formKey,
            onGetFocus: () => null,
            onLoseFocus: () => null,
            validator: (text) {
              if (text.isEmpty) {
                return "Field cannot be empty";
              }
              if (text.length > 5) {
                return "Text is too long";
              }
              return null;
            },
            onSaved: (text) => null,
          ),
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
