extension NullOrEmpty on String? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;
}

extension CodeUnit on String {
  int get codeUnit {
    if (codeUnits.length > 1) {
      ArgumentError.value("The string $this has more code units than 1");
    }
    return codeUnitAt(0);
  }
}
