import 'package:flutter/material.dart' hide SearchController;

import '../../../models/sections/search_section.dart';
import '../../../theme/theme.dart';
import '../../../widgets/balun_button.dart';

class SearchSections extends StatelessWidget {
  final Map<int, GlobalKey> itemKeys;
  final SearchSection activeSearchSection;
  final Function(SearchSection pressedSection) titlePressed;

  const SearchSections({
    required this.itemKeys,
    required this.activeSearchSection,
    required this.titlePressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 70,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      physics: const BouncingScrollPhysics(),
      itemCount: SearchSectionEnum.values.length,
      itemBuilder: (_, index) {
        final section = SearchSection(
          searchSectionEnum: SearchSectionEnum.values[index],
        );

        return BalunButton(
          key: itemKeys[section.searchSectionEnum.index],
          onPressed: () => titlePressed(section),
          child: Center(
            child: Text(
              section.getSearchSectionName(),
              style: activeSearchSection == section ? context.textStyles.titleMdExtraBold : context.textStyles.bodyLgMuted,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 40),
    ),
  );
}
