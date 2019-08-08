import 'package:flutter_web/material.dart';

class RealTimeValidatedTextFormField extends StatefulWidget {
  RealTimeValidatedTextFormField(
      {Key key,
      TextEditingController controller,
      String initialValue,
      FocusNode focusNode,
      InputDecoration decoration = const InputDecoration(),
      TextInputType keyboardType,
      TextCapitalization textCapitalization = TextCapitalization.none,
      TextInputAction textInputAction,
      TextStyle style,
      TextDirection textDirection,
      TextAlign textAlign = TextAlign.start,
      bool autofocus = false,
      bool obscureText = false,
      bool autocorrect = true,
      bool autovalidate = false,
      bool maxLengthEnforced = true,
      int maxLines = 1,
      int maxLength,
      VoidCallback onEditingComplete,
      ValueChanged<String> onFieldSubmitted,
      List<TextInputFormatter> inputFormatters,
      bool enabled = true,
      double cursorWidth = 2.0,
      Radius cursorRadius,
      Color cursorColor,
      Brightness keyboardAppearance,
      EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
      bool enableInteractiveSelection = true,
      InputCounterWidgetBuilder buildCounter,
      @required GlobalKey<FormState> formState, //
      VoidCallback onGetFocus, //
      VoidCallback onLoseFocus, //
      Function(String) onSaved, //
      String Function(String) validator //
      })
      : assert(formState != null),
        formKey = formState,
        _key = key,
        _controller = controller ?? TextEditingController(),
        _focusNode = focusNode ?? FocusNode(),
        _onGetFocus = onGetFocus,
        _onLoseFocus = onLoseFocus,
        _onSaved = onSaved,
        _validator = validator,
        _initialValue = initialValue,
        _decoration = decoration,
        _keyboardType = keyboardType,
        _textCapitalization = textCapitalization,
        _textInputAction = textInputAction,
        _style = style,
        _textDirection = textDirection,
        _textAlign = textAlign,
        _autofocus = autofocus,
        _obscureText = obscureText,
        _autocorrect = autocorrect,
        _autovalidate = autovalidate,
        _maxLengthEnforced = maxLengthEnforced,
        _maxLines = maxLines,
        _maxLength = maxLength,
        _onEditingComplete = onEditingComplete,
        _onFieldSubmitted = onFieldSubmitted,
        _inputFormatters = inputFormatters,
        _enabled = enabled,
        _cursorWidth = cursorWidth,
        _cursorRadius = cursorRadius,
        _cursorColor = cursorColor,
        _keyboardAppearance = keyboardAppearance,
        _scrollPadding = scrollPadding,
        _enableInteractiveSelection = enableInteractiveSelection,
        _buildCounter = buildCounter;

  final GlobalKey<FormState> formKey;

  final bool _autocorrect;
  final bool _autofocus;
  final bool _autovalidate;
  final InputCounterWidgetBuilder _buildCounter;
  final TextEditingController _controller;
  final Color _cursorColor;
  final Radius _cursorRadius;
  final double _cursorWidth;
  final InputDecoration _decoration;
  final bool _enabled;
  final bool _enableInteractiveSelection;
  final FocusNode _focusNode;
  final String _initialValue;
  final List<TextInputFormatter> _inputFormatters;
  final Key _key;
  final Brightness _keyboardAppearance;
  final TextInputType _keyboardType;
  final int _maxLength;
  final bool _maxLengthEnforced;
  final int _maxLines;
  final bool _obscureText;
  final VoidCallback _onEditingComplete;
  final ValueChanged<String> _onFieldSubmitted;
  final VoidCallback _onGetFocus;
  final VoidCallback _onLoseFocus;
  final EdgeInsets _scrollPadding;
  final TextStyle _style;
  final TextAlign _textAlign;
  final TextCapitalization _textCapitalization;
  final TextDirection _textDirection;
  final TextInputAction _textInputAction;

  final Function(String) _onSaved;

  final String Function(String) _validator;

  _RealTimeValidatetTextFormFieldState createState() =>
      _RealTimeValidatetTextFormFieldState();
}

class _RealTimeValidatetTextFormFieldState
    extends State<RealTimeValidatedTextFormField> {
  var _isFocused = false;
  var _lastText = "";

  @override
  void initState() {
    super.initState();

    _addFocusNodeListener();
    _addTextEditControllerListener();
  }

  final String Function(String) _alwaysPassingValidator = (text) => null;

  void _addFocusNodeListener() {
    final _focus = widget._focusNode;
    _focus.addListener(
        () => _focus.hasFocus ? _gotFocusCallback() : _lostFocusCallback());
  }

  void _addTextEditControllerListener() {
    widget._controller.addListener(() {
      if (_lastText != widget._controller.text) {
        _onTextChanged();
      }
      _lastText = widget._controller.text;
      _isFocused = false;
    });
  }

  void _onTextChanged() {
    _removeValidationError();
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
  }

  String _validate(String text) {
    final String validationResult = _isFocused
        ? _alwaysPassingValidator(text)
        : widget._validator(text) ?? _alwaysPassingValidator(text);

    return validationResult;
  }

  Widget _createTextfield({String Function(String) validator}) {
    return TextFormField(
      focusNode: widget._focusNode,
      controller: widget._controller,
      onSaved: widget._onSaved,
      validator: validator,
      key: widget._key,
      autocorrect: widget._autocorrect,
      autofocus: widget._autofocus,
      autovalidate: widget._autovalidate,
      buildCounter: widget._buildCounter,
      cursorColor: widget._cursorColor,
      cursorRadius: widget._cursorRadius,
      cursorWidth: widget._cursorWidth,
      decoration: widget._decoration,
      enabled: widget._enabled,
      enableInteractiveSelection: widget._enableInteractiveSelection,
      initialValue: widget._initialValue,
      inputFormatters: widget._inputFormatters,
      keyboardAppearance: widget._keyboardAppearance,
      keyboardType: widget._keyboardType,
      maxLength: widget._maxLength,
      maxLengthEnforced: widget._maxLengthEnforced,
      maxLines: widget._maxLines,
      obscureText: widget._obscureText,
      onEditingComplete: widget._onEditingComplete,
      onFieldSubmitted: widget._onFieldSubmitted,
      scrollPadding: widget._scrollPadding,
      style: widget._style,
      textAlign: widget._textAlign,
      textCapitalization: widget._textCapitalization,
      textDirection: widget._textDirection,
      textInputAction: widget._textInputAction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _createTextfield(validator: _validate);
  }
}
