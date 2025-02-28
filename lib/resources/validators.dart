// Email validation function
bool validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return false;
  }
  String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(emailPattern);
  if (!regex.hasMatch(value)) {
    return true;
  }
  return false;
}
