class CurrencyPair {
  const CurrencyPair({
    required this.one,
    required this.two,
    required this.description,
    required this.free,
    required this.koef,
  });

  final String one;
  final String two;

  final String description;
  final bool free;

  /// Приблизительный коэффициент отношения одной валюты к другой.
  final double koef;
}
