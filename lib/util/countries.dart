import '../models/countries/country_response.dart';

List<CountryResponse> sortCountries(List<CountryResponse> countries) {
  final posOrder = {
    'World': 0,
    'Croatia': 1,
    'England': 2,
    'Spain': 3,
    'Germany': 4,
    'Italy': 5,
    'France': 6,
  };

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
