import 'package:flutter/material.dart' hide SearchController;

import '../../../models/search_section.dart';
import '../../../theme/theme.dart';
import '../../../util/dependencies.dart';
import '../../../widgets/balun_button.dart';
import '../controllers/search_controller.dart';

class SearchSections extends StatelessWidget {
  final SearchSection activeSearchSection;
  final Function(SearchSection pressedSection) titlePressed;
  final PageController controller;

  const SearchSections({
    required this.activeSearchSection,
    required this.titlePressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 70,
        child: PageView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            SearchSectionEnum.values.length,
            (index) {
              final section = SearchSection(
                searchSectionEnum: SearchSectionEnum.values[index],
              );

              return BalunButton(
                onPressed: () => getIt
                    .get<SearchController>(
                      instanceName: 'search',
                    )
                    .updateState(section),
                child: Center(
                  child: Text(
                    section.getSearchSectionName(),
                    style: activeSearchSection == section ? context.textStyles.searchPickerActive : context.textStyles.searchPickerInactive,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
      );
}
