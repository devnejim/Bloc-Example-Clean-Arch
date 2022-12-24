extension StringExtension on String {
  String get capitalizeFirst =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);

  String get capitalizeFirstOfEach =>
      isEmpty ? this : split(' ').map((e) => e.capitalizeFirst).join(' ');

  String get trimAndLower => trim().toLowerCase();

  bool get nullOrEmpty => isEmpty ? true : false;

  String get hardCoded => this;

  String get removeNumsFromString => replaceAll(RegExp(r'[-.,0-9 ]'), '');

  int get getNumsFromString => int.tryParse(replaceAll(RegExp(r'[^0-9]'), ''))!;
}

extension NullableStringExtension on String? {
  bool get nullOrEmpty => this == null || this!.isEmpty ? true : false;
}
