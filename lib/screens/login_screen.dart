import 'package:flutter_web/material.dart';
import 'package:stock_notes/widgets/real_time_validated_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];

    return Column(
      children: <Widget>[
        Form(
          key: _formKeys[0],
          child: RealTimeValidatedTextFormField(
            formState: _formKeys[0],
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
            onSaved: (text) => print("1 saved"),
          ),
        ),
        Form(
          key: _formKeys[1],
          child: RealTimeValidatedTextFormField(
            formState: _formKeys[1],
            onGetFocus: () => null,
            onLoseFocus: () => null,
            validator: (text) {
              if (text.isEmpty) {
                return "Field cannot be empty";
              }
              if (!text.contains("@")) {
                return "Text must contain @";
              }
              return null;
            },
            onSaved: (text) =>  print("2 saved"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              final validatedSuccessfully = _formKeys
                      .map((key) => key.currentState.validate())
                      .where((validated) => validated)
                      .toList()
                      .length ==
                  _formKeys.length;

              if (validatedSuccessfully) {
                // If the form is valid, display a Snackbar.
                _formKeys.forEach((key) => key.currentState.save());
              }
            },
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }
}
