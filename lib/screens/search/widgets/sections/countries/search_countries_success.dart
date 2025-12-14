import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../models/search/search_countries/search_countries_inner_response.dart';
import '../../../../../routing.dart';
import 'search_countries_list_tile.dart';

class SearchCountriesSuccess extends StatelessWidget {
  final List<SearchCountriesInnerResponse> countries;

  const SearchCountriesSuccess({
    required this.countries,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
    padding: const EdgeInsets.only(bottom: 24),
    physics: const BouncingScrollPhysics(),
    itemCount: countries.length,
    itemBuilder: (_, index) {
      final country = countries[index];

      return SearchCountriesListTile(
        country: country,
        countryPressed: country.name != null
            ? () {
                HapticFeedback.lightImpact();
                openLeagues(
                  context,
                  country: country.name!,
                );
              }
            : null,
      );
    },
    separatorBuilder: (_, __) => const SizedBox(height: 4),
  );
}
