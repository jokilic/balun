import 'package:flutter/material.dart';

import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../models/countries/country_response.dart';
import '../../../theme/icons.dart';

class CountriesListTile extends StatelessWidget {
  final CountryResponse country;
  final Function()? countryPressed;

  const CountriesListTile({
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
                      )
                    : Container(
                        padding: const EdgeInsets.all(8),
                        color: context.colors.white,
                        child: const BalunImage(
                          imageUrl: BalunIcons.countryPlaceholder,
                          height: 28,
                          width: 28,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  country.name ?? 'Unknown',
                  style: context.textStyles.fixturesCountry,
                ),
              ),
            ],
          ),
        ),
      );
}
