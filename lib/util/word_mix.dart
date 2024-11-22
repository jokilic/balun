import 'dart:math';

/// Takes `input` and returns every `word` with mixed letters
String? mixWords(String? input) {
  if (input == null) {
    return null;
  }

  /// Split input into words and mix each one
  return input.split(' ').map((word) => mixWord(word, random: Random())).join(' ');
}

String mixWord(
  String word, {
  required Random random,
}) {
  /// Handle cases based on `word` length
  /// 1 or 2 letters: return the `word` as is
  if (word.length <= 2) {
    return word;
  } else if (word.length == 3) {
    /// 3 letters: first letter same, mix the last two
    return word[0] + word[2] + word[1];
  } else {
    /// 4 or more letters: first and last letters same, mix the middle
    final first = word[0];
    final last = word[word.length - 1];
    final middle = word.substring(1, word.length - 1).split('');

    /// Shuffle the middle letters by swapping two adjacent letters randomly
    if (middle.length > 1) {
      final pos = random.nextInt(middle.length - 1);
      final temp = middle[pos];

      middle[pos] = middle[pos + 1];
      middle[pos + 1] = temp;
    }

    /// Reassemble the word
    return first + middle.join() + last;
  }
}
