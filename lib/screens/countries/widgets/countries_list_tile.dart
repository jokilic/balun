import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_button.dart';
import '../../../../../../widgets/balun_image.dart';
import '../../../models/countries/country_response.dart';

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
                borderRadius: BorderRadius.circular(8),
                child: BalunImage(
                  imageUrl: country.flag ?? BalunImages.placeholderLogo,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  country.name ?? 'Unknown',
                  style: context.textStyles.countriesName,
                ),
              ),
            ],
          ),
        ),
      );
}
