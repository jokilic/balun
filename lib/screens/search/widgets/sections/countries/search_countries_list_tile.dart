import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../../../models/search/search_countries/search_countries_inner_response.dart';
import '../../../../../theme/icons.dart';
import '../../../../../util/word_mix.dart';

class SearchCountriesListTile extends StatelessWidget {
  final SearchCountriesInnerResponse country;
  final Function()? countryPressed;

  const SearchCountriesListTile({
    required this.country,
    required this.countryPressed,
  });

  @override
  Widget build(BuildContext context) => BalunButton(
        onPressed: countryPressed,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: country.flag != null
                    ? BalunImage(
                        imageUrl: country.flag!,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        padding: const EdgeInsets.all(8),
                        color: context.colors.white,
                        child: const BalunImage(
                          imageUrl: BalunIcons.placeholderCountry,
                          height: 28,
                          width: 28,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  mixOrOriginalWords(country.name ?? '---') ?? '---',
                  style: context.textStyles.fixturesCountry,
                ),
              ),
            ],
          ),
        ),
      );
}
