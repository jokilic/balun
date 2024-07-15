String getLastWord(String input) {
  final words = input.split(' ');
  return words.isNotEmpty ? words.last : '';
}
