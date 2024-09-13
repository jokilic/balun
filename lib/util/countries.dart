import '../constants.dart';
import '../models/countries/country_response.dart';

List<CountryResponse> sortCountries(List<CountryResponse> countries) {
  const popularCountryIDs = BalunConstants.popularCountryIDs;

  countries.sort((a, b) {
    // Handle null names
    if (a.name == null && b.name == null) {
      return 0;
    }
    if (a.name == null) {
      return 1;
    }
    if (b.name == null) {
      return -1;
    }

    // Check if countries are in the popularCountryIDs list
    final isAPopular = popularCountryIDs.contains(a.name);
    final isBPopular = popularCountryIDs.contains(b.name);

    if (isAPopular && isBPopular) {
      // Both countries are popular, sort by their order in popularCountryIDs
      return popularCountryIDs.indexOf(a.name!).compareTo(popularCountryIDs.indexOf(b.name!));
    } else if (isAPopular) {
      // Only A is popular, it should come first
      return -1;
    } else if (isBPopular) {
      // Only B is popular, it should come first
      return 1;
    } else {
      // Neither country is popular, sort alphabetically
      return a.name!.compareTo(b.name!);
    }
  });

  return countries;
}
