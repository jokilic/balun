import 'dart:math';

double getRandomNumberFromBase(int numberBase) {
  final minNumber = max(numberBase - 40, 24);
  final maxNumber = numberBase + 40;

  return minNumber + Random().nextInt(maxNumber - minNumber + 1).toDouble();
}
