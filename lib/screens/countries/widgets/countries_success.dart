import 'package:flutter/material.dart';

import '../../../models/countries/country_response.dart';
import '../../../routing.dart';
import '../../../util/countries.dart';
import 'countries_list_tile.dart';

class CountriesSuccess extends StatelessWidget {
  final List<CountryResponse> countries;

  const CountriesSuccess({
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    final sortedCountries = sortCountries(countries);

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: sortedCountries.length,
      itemBuilder: (_, index) {
        final country = sortedCountries[index];

        return CountriesListTile(
          country: country,
          countryPressed: country.name != null
              ? () => openLeagues(
                    context,
                    country: country.name!,
                  )
              : null,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 4),
    );
  }
}
