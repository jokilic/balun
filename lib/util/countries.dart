import '../constants.dart';
import '../models/countries/country_response.dart';

List<CountryResponse> sortCountries(List<CountryResponse> countries) {
  const posOrder = BalunConstants.countriesOrder;

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

    final priorityA = posOrder[a.name] ?? posOrder.length;
    final priorityB = posOrder[b.name] ?? posOrder.length;

    if (priorityA != priorityB) {
      return priorityA.compareTo(priorityB);
    } else {
      return a.name!.compareTo(b.name!);
    }
  });

  return countries;
}
