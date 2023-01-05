import 'dart:collection';

String? validateNotEmpty(String value, String fieldName) {
  if (value.isNotEmpty) {
    return null;
  }
  return '$fieldName cannot be empty';
}
