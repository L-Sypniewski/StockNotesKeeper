import 'package:flutter_web/material.dart';
import 'package:stock_notes/persistence/firestore/firestore_stock_database.dart';
import 'package:stock_notes/widgets/real_time_validated_form.dart';
import 'package:stock_notes/widgets/real_time_validated_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKeys = [
      GlobalKey<FormState>(),
      GlobalKey<FormState>(),
      GlobalKey<FormState>()
    ];

    final textField1 = RealTimeValidatedTextFormField(
      decoration: InputDecoration(
          prefixIcon: Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ))),
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
    );

    final textField2 = RealTimeValidatedTextFormField(
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
      onSaved: (text) => print("2 saved"),
    );

    final textField3 = RealTimeValidatedTextFormField(
      formState: _formKeys[2],
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
      onSaved: (text) => print("2 saved"),
    );

    var realTimeForm = RealTimeValidatedForm(
      children: [textField1, textField2, textField3],
    );

    return Column(
      children: <Widget>[
        realTimeForm,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
              realTimeForm.save();
              FirestoreNotesDatabase();
            },
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }
}
