extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String camelCaseToTitleCase() {
    if (isEmpty) return '';
    String titleCase = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i].toUpperCase() == this[i] && !this[i].startsWith(RegExp(r'[0-9]'))) {
        titleCase += ' ${this[i]}';
      } else {
        if (this[i].startsWith(RegExp(r'[0-9]')) && i - 1 >= 0 && !this[i - 1].startsWith(RegExp(r'[0-9]'))) {
          titleCase += ' ${this[i]}';
        } else {
          titleCase += this[i];
        }
      }
    }
    return titleCase;
  }
}
