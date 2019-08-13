import 'package:flutter_web/material.dart';
import 'package:stock_notes/model/validator/standard_validator.dart';
import 'package:stock_notes/model/validator/validator.dart';
import 'package:stock_notes/persistence/firestore/firestore_stock_database.dart';
import 'package:stock_notes/widgets/real_time_validated_form.dart';
import 'package:stock_notes/widgets/real_time_validated_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int numberOfRealTimeValidatedTextFields = 3;
    final List<GlobalKey> _formKeys =
        _generateGlobalKey(count: numberOfRealTimeValidatedTextFields);

    final Validator validator = StandardValidator();

    final urlTextField = RealTimeValidatedTextFormField(
      decoration: InputDecoration(
          prefixIcon: Padding(
              padding: EdgeInsets.all(0.0),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ))),
      formState: _formKeys[0],
      validator: (text) => validator.url(text, optional: true),
      onSaved: (text) => print("1 saved"),
    );

    final emailTextField = RealTimeValidatedTextFormField(
      formState: _formKeys[1],
      onGetFocus: () => null,
      onLoseFocus: () => null,
      validator: (text) => validator.email(text, optional: false),
      onSaved: (text) => print("2 saved"),
    );

    final shortTextField = RealTimeValidatedTextFormField(
      formState: _formKeys[2],
      onGetFocus: () => null,
      onLoseFocus: () => null,
      validator: (text) => validator.length(text, minLength: 3, maxLength: 5),
      onSaved: (text) => print("3 saved"),
    );

    var realTimeForm = RealTimeValidatedForm(
      children: [urlTextField, emailTextField, shortTextField],
    );

    assert(realTimeForm.children.length == numberOfRealTimeValidatedTextFields);

    return Column(
      children: <Widget>[
        realTimeForm,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
              realTimeForm.save();
            },
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }

  List<GlobalKey> _generateGlobalKey({int count}) {
    return Iterable<int>.generate(count)
        .map((i) => GlobalKey<FormState>())
        .toList();
  }
}
