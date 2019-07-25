import 'package:flutter_web/material.dart';
import 'package:stock_notes/widgets/real_time_validated_text_form_field.dart';

class RealTimeValidatedForm extends StatelessWidget {
  RealTimeValidatedForm({this.children})
      : assert(children != null),
        _formKeys = children.map((child) => child.formKey).toList();

  final List<RealTimeValidatedTextFormField> children;

  final List<GlobalKey<FormState>> _formKeys;

  bool validate() {
    final validatedSuccessfully = _formKeys
            .map((key) => key.currentState.validate())
            .where((validated) => validated)
            .toList()
            .length ==
        _formKeys.length;

    return validatedSuccessfully;
  }

  void save() {
    if (validate()) {
      _formKeys.forEach((key) => key.currentState.save());
    }
  }

  List<Widget> _formsWithTextFields(
      List<RealTimeValidatedTextFormField> textFields) {
    return textFields
        .map((textField) => Form(
              key: textField.formKey,
              child: textField,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: _formsWithTextFields(children),
    ));
  }
}
