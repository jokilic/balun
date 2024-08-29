import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String value) onSubmitted;

  const SearchBarWidget({
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );

    return TextField(
      onSubmitted: onSubmitted,
      autofocus: true,
      cursorColor: context.colors.black,
      style: context.textStyles.searchTextField,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp('[a-zA-Z]'),
        ),
      ],
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colors.white.withOpacity(0.4),
        errorBorder: border,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        contentPadding: const EdgeInsets.all(16),
        hintText: 'Search...',
        hintStyle: context.textStyles.searchTextField.copyWith(
          color: context.colors.black.withOpacity(0.5),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            BalunIcons.search,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
