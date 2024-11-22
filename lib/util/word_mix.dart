import 'dart:math';

String? mixWords(String? input) {
  if (input == null) {
    return null;
  }

  /// Split input into `words` and mix each one
  return input.split(' ').map((word) => mixWord(word, random: Random())).join(' ');
}

/// Handle cases based on `word` length
String mixWord(
  String word, {
  required Random random,
}) {
  /// 1 or 2 letters: return the `word` as is
  if (word.length <= 2) {
    return word;
  }

  /// 3 letters: first letter same, mix the last two
  else if (word.length == 3) {
    return word[0] + word[2] + word[1];
  }

  /// 4 or more letters: first and last letters same, mix the middle
  else {
    final first = word[0];
    final last = word[word.length - 1];
    final middle = word.substring(1, word.length - 1);

    /// If middle has exactly two letters, just swap them
    if (middle.length == 2) {
      return first + middle[1] + middle[0] + last;
    }

    /// For more than two middle letters
    else {
      final midIndex = middle.length ~/ 2;

      /// Split the middle into parts around the middle index
      final beforeMiddle = middle.substring(0, midIndex - 1);
      final firstMiddle = middle[midIndex - 1];
      final secondMiddle = middle[midIndex];
      final afterMiddle = middle.substring(midIndex + 1);

      /// Swap the two middle letters
      final mixedMiddle = beforeMiddle + secondMiddle + firstMiddle + afterMiddle;

      return first + mixedMiddle + last;
    }
  }
}
