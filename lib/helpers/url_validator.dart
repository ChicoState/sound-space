//url validator for use in uploads
bool validateUrl(String? value) {
  String pattern =
      r'(^https://[a-zA-z/[.com,.edu,.gov,.org,.net]?]*)'; // NEEDS UPDATING LATER
  RegExp regExp = new RegExp(pattern);
  if (value == null || !regExp.hasMatch(value)) {
    // failed validation
    return false;
  }
  // passed validation
  return true;
}
