List<int> generateYearList() => List.generate(
      DateTime.now().year - 1999,
      (index) => 2000 + index,
    );
