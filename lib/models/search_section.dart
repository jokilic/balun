import 'package:easy_localization/easy_localization.dart';

enum SearchSectionEnum {
  countries,
  leagues,
  teams,
  coaches,
}

class SearchSection {
  final SearchSectionEnum searchSectionEnum;

  SearchSection({
    required this.searchSectionEnum,
  });

  String getSearchSectionName() => switch (searchSectionEnum) {
        SearchSectionEnum.countries => 'searchSectionCountries'.tr(),
        SearchSectionEnum.leagues => 'searchSectionLeagues'.tr(),
        SearchSectionEnum.teams => 'searchSectionTeams'.tr(),
        SearchSectionEnum.coaches => 'searchSectionCoaches'.tr(),
      };

  @override
  String toString() => 'SearchSection(SearchSectionEnum: $SearchSectionEnum)';

  @override
  bool operator ==(covariant SearchSection other) {
    if (identical(this, other)) {
      return true;
    }

    return other.searchSectionEnum == searchSectionEnum;
  }

  @override
  int get hashCode => searchSectionEnum.hashCode;
}
