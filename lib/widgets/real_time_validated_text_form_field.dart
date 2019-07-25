import 'package:flutter_web/material.dart';

class RealTimeValidatedTextFormField extends StatefulWidget {
  RealTimeValidatedTextFormField(
      //TODO - pass TextFormField in constructor and wrap it with RealTimeValidatedTextFormField
      {@required GlobalKey<FormState> formState,
      VoidCallback onGetFocus,
      VoidCallback onLoseFocus,
      Function(String) onSaved,
      String Function(String) validator})
      : assert(formState != null),
        formKey = formState,
        _onGetFocus = onGetFocus,
        _onLoseFocus = onLoseFocus,
        _onSaved = onSaved,
        _validator = validator;

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> formKey;
  final VoidCallback _onGetFocus;
  final VoidCallback _onLoseFocus;

  final Function(String) _onSaved;

  final String Function(String) _validator;

  final String Function(String) _alwaysPassingValidator = (text) => null;

  _RealTimeValidatetTextFormFieldState createState() =>
      _RealTimeValidatetTextFormFieldState();
}

class _RealTimeValidatetTextFormFieldState
    extends State<RealTimeValidatedTextFormField> {
  final _focus = FocusNode();
  var _isFocused = true;
  var _lastText = "";

  @override
  void initState() {
    super.initState();
    print('Key: ${widget.formKey}');

    _focus.addListener(
        () => _focus.hasFocus ? _gotFocusCallback() : _lostFocusCallback());

    widget._controller.addListener(() {
      if (_lastText != widget._controller.text) {
        _onTextChanged();
      }
      _lastText = widget._controller.text;
      print('listnerer');
      _isFocused = false;
    });
  }

  void _onTextChanged() {
    print("Text changed");
    if (true) {
      _removeValidationError();
    }
  }

  void _removeValidationError() {
    if (!_isFocused) {
      _setStateAndValidateForm(isFocusedNewValue: true);
    }
  }

  void _gotFocusCallback() {
    _setStateAndValidateForm(isFocusedNewValue: true);
    widget._onGetFocus();
    _isFocused = false;
    print("_gotFocusCallback");
  }

  void _setStateAndValidateForm({@required bool isFocusedNewValue}) {
    setState(() {
      _isFocused = isFocusedNewValue;
    });
    _validateForm();
  }

  void _validateForm() {
    widget.formKey.currentState.validate();
  }

  void _lostFocusCallback() {
    _setStateAndValidateForm(isFocusedNewValue: false);
    widget._onLoseFocus();
    print("_lostFocusCallback");
  }

  String _validate(String text) {
    final String validationResult = _isFocused
        ? widget._alwaysPassingValidator(text)
        : widget._validator(text) ?? widget._alwaysPassingValidator(text);

    return validationResult;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focus,
      controller: widget._controller,
      onSaved: widget._onSaved,
      validator: _validate,
    );
  }
}
