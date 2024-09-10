import '../constants.dart';
import '../models/countries/country_response.dart';

List<CountryResponse> sortCountries(List<CountryResponse> countries) {
  const countryOrder = BalunConstants.popularCountryIDs;

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

    final priorityA = a.name != null ? countryOrder.indexOf(a.name!) : countryOrder.length;
    final priorityB = b.name != null ? countryOrder.indexOf(b.name!) : countryOrder.length;

    if (priorityA != priorityB) {
      return priorityA.compareTo(priorityB);
    } else {
      return a.name!.compareTo(b.name!);
    }
  });

  return countries;
}
