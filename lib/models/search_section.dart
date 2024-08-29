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
        SearchSectionEnum.countries => 'Countries',
        SearchSectionEnum.leagues => 'Leagues',
        SearchSectionEnum.teams => 'Teams',
        SearchSectionEnum.coaches => 'Coaches',
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
