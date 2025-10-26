import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide SearchController;

import '../../../theme/icons.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/balun_button.dart';
import '../../../widgets/balun_image.dart';
import '../controllers/search_controller.dart';

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

    final textEditingController = getIt
        .get<SearchController>(
          instanceName: 'search',
        )
        .textEditingController;

    return TextField(
      controller: textEditingController,
      onSubmitted: onSubmitted,
      cursorColor: context.colors.primaryForeground,
      style: context.textStyles.searchTextField,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        fillColor: context.colors.primaryBackground.withValues(alpha: 0.4),
        errorBorder: border,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        contentPadding: const EdgeInsets.all(16),
        hintText: 'searchHint'.tr(),
        hintStyle: context.textStyles.searchTextField.copyWith(
          color: context.colors.primaryForeground.withValues(alpha: 0.5),
        ),
        suffixIcon: BalunButton(
          onPressed: () => onSubmitted(textEditingController.text),
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(10),
            child: const BalunImage(
              imageUrl: BalunIcons.search,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }
}
