extension StringExtension on String {
  bool get isValidEmail {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(r'^[0-9]{10,13}$').hasMatch(this);
  }

  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String toTitleCase() {
    return split(' ')
        .map((word) => word.isEmpty ? '' : word.capitalize())
        .join(' ');
  }
}
