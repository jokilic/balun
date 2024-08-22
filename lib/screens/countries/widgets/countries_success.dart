import 'package:flutter/material.dart';

import '../../../models/countries/country_response.dart';
import 'countries_list_tile.dart';

class CountriesSuccess extends StatelessWidget {
  final List<CountryResponse> countries;

  const CountriesSuccess({
    required this.countries,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: countries.length,
        itemBuilder: (_, index) {
          final country = countries[index];

          return CountriesListTile(
            country: country,
            countryPressed: () {},
          );
        },
      );
}
