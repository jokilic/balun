import 'util/env.dart';

class BalunConstants {
  static const animationDuration = Duration(milliseconds: 250);
  static const buttonScaleDuration = Duration(milliseconds: 125);
  static const shimmerDuration = Duration(milliseconds: 1500);
  static const cacheDuration = Duration(days: 3);
}

class BalunEndpoints {
  static final baseUrl = Env.apiFootballBaseUrl;
}

class BalunImages {
  // TODO: Proper placeholder image
  static const placeholderLogo = 'assets/icon.png';
}
