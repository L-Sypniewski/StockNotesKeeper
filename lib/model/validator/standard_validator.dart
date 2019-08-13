import 'package:stock_notes/model/validator/validator.dart';
import 'package:validators/validators.dart';

class StandardValidator extends Validator {
  @override
  String email(String text, {bool optional = false, int maxLength = -1}) {
    String textIsEmail =
        _validate(text, ValidatorType.email, optional: optional);
    String textHasCorrectLength =
        checkIfTextHasCorrectLength(text, optional ? 0 : 1, maxLength);

    return textHasCorrectLength != null ? textHasCorrectLength : textIsEmail;
  }

  String checkIfTextHasCorrectLength(
      String text, int minLength, int maxLength) {
    String textHasCorrectLength = _validateLength(text, minLength, maxLength);

    return textHasCorrectLength != null ? textHasCorrectLength : null;
  }

  @override
  String notEmpty(String text) {
    return _validate(text, ValidatorType.notEmpty, optional: false);
  }

  @override
  String url(String text, {bool optional = false, int maxLength = -1}) {
    String textIsUrl = _validate(text, ValidatorType.url, optional: optional);
    String textHasCorrectLength =
        checkIfTextHasCorrectLength(text, optional ? 0 : 1, maxLength);

    return textHasCorrectLength != null ? textHasCorrectLength : textIsUrl;
  }

  @override
  String length(String text, {int minLength = 0, int maxLength = -1}) {
    return _validateLength(text, minLength, maxLength);
  }

  String _validateLength(String text, int minLength, int maxLength) {
    assert(minLength <= maxLength);

    int sanedMinLength = minLength < 0 ? 0 : minLength;
    if (sanedMinLength > 0 && text.isEmpty) {
      return validationErrorMessages[ValidatorType.notEmpty];
    }

    if (text.length < sanedMinLength) {
      return "Minimum text length equals $sanedMinLength";
    }

    if (maxLength >= 0 && text.length > maxLength) {
      return "Maximum text length equals $maxLength";
    }

    return null;
  }

  String _validate(String text, ValidatorType validatorType, {bool optional}) {
    assert(text != null);
    assert(validatorType != null);
    assert(optional != null);

    if (optional && text.isEmpty) {
      return null;
    }

    switch (validatorType) {
      case ValidatorType.email:
        return isEmail(text) ? null : validationErrorMessages[validatorType];
        break;
      case ValidatorType.notEmpty:
        return text.isNotEmpty ? null : validationErrorMessages[validatorType];
        break;
      case ValidatorType.url:
        return isURL(text) ? null : validationErrorMessages[validatorType];
        break;
      default:
        return null;
    }
  }

  Map<ValidatorType, String> validationErrorMessages = {
    ValidatorType.email: "Email is not valid",
    ValidatorType.notEmpty: "Text must not be empty",
    ValidatorType.url: "Text is not valid url"
  };
}

enum ValidatorType { email, notEmpty, url }
