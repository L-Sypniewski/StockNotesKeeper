import 'package:flutter_web/material.dart';

class RealTimeValidatedTextFormField extends StatefulWidget {
  final GlobalKey<FormState> _formState;
  final VoidCallback _onGetFocus;
  final VoidCallback _onLoseFocus;
  final Function(String) _onSaved;
  final String Function(String) _validator;

  final String Function(String) _alwaysPassingValidator = (text) => null;
  final TextEditingController _controller = TextEditingController();

  RealTimeValidatedTextFormField(
      {@required GlobalKey<FormState> formState,
      VoidCallback onGetFocus,
      VoidCallback onLoseFocus,
      Function(String) onSaved,
      String Function(String) validator})
      : assert(formState != null),
        _formState = formState,
        _onGetFocus = onGetFocus,
        _onLoseFocus = onLoseFocus,
        _onSaved = onSaved,
        _validator = validator;

  _RealTimeValidatetTextFormFieldState createState() =>
      _RealTimeValidatetTextFormFieldState();
}

class _RealTimeValidatetTextFormFieldState
    extends State<RealTimeValidatedTextFormField> {
  final _focus = FocusNode();
  var _willBeFocused = true;
  var _validationCorrect = true;

  @override
  void initState() {
    super.initState();

    _focus.addListener(() => _focus.hasFocus
        ? _gotFocusCallback()
        : _lostFocusCallback());

    widget._controller.addListener(() {
      setState(() {
        _willBeFocused = true;
      });
    });
  }

  void _gotFocusCallback() {
    setState(() {
      _willBeFocused = false;
    });
    _validateForm();

    widget._onGetFocus();
    _willBeFocused = true;
  }

  void _validateForm() {
    widget._formState.currentState.validate();
  }

  void _lostFocusCallback() {
    setState(() {
      _willBeFocused = true;
    });
    _validateForm();

    widget._onLoseFocus();
  }

  String _validate(String text) {
    final String validationResult = _willBeFocused
        ? widget._validator(text) ?? widget._alwaysPassingValidator(text)
        : widget._alwaysPassingValidator(text);

    _validationCorrect = validationResult == null;
    print(
        'Validation result $_validationCorrect , willBeFocused: $_willBeFocused');
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
