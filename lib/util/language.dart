import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void toggleLanguage(BuildContext context) => context.setLocale(
      Locale(context.locale == const Locale('en') ? 'hr' : 'en'),
    );
