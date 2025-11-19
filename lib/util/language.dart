import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> toggleLanguage(BuildContext context) async => context.setLocale(
  Locale(context.locale == const Locale('en') ? 'hr' : 'en'),
);
