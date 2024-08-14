int compareRounds(String a, String b) {
  /// Extract numbers from Strings if they exist
  final regexNumber = RegExp(r'\d+');

  final aMatch = regexNumber.firstMatch(a);
  final bMatch = regexNumber.firstMatch(b);

  /// Both strings contain numbers, compare them numerically
  if (aMatch != null && bMatch != null) {
    return int.parse(aMatch.group(0)!).compareTo(
      int.parse(bMatch.group(0)!),
    );
  }

  /// Only `a` contains a number, it should come first
  else if (aMatch != null) {
    return -1;
  }

  /// Only `b` contains a number, it should come first
  else if (bMatch != null) {
    return 1;
  }

  /// Neither String contains a number, compare alphabetically
  else {
    return a.compareTo(b);
  }
}
