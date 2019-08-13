abstract class Validator {
  String url(String text, {bool optional = false, int maxLength = -1});
  String email(String text, {bool optional = false, int maxLength = -1});
  String notEmpty(String text);
  String length(String text, {int minLength = 0, int maxLength = -1});
}
