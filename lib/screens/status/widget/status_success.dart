import 'package:flutter/material.dart';

import '../../../models/status/status_inner_response.dart';

class StatusSuccess extends StatelessWidget {
  final StatusInnerResponse status;

  const StatusSuccess({
    required this.status,
  });

  // TODO: Logo of API-Football with link to site and data below
  @override
  Widget build(BuildContext context) {
    return Text(status.account?.firstName ?? 'No name');

    // return ListView.separated(
    //   padding: const EdgeInsets.only(bottom: 24),
    //   physics: const BouncingScrollPhysics(),
    //   itemCount: sortedCountries.length,
    //   itemBuilder: (_, index) {
    //     final country = sortedCountries[index];

    //     return CountriesListTile(
    //       country: country,
    //       countryPressed: country.name != null
    //           ? () => openLeagues(
    //               context,
    //               country: country.name!,
    //             )
    //           : null,
    //     );
    //   },
    //   separatorBuilder: (_, __) => const SizedBox(height: 4),
    // );
  }
}
