class ValueHistory {
  const ValueHistory({
    required this.rate,
    required this.timestamp,
  });

  /// Соотношение одной валюты к другой.
  final double rate;

  /// Время этого соотношения.
  final int timestamp;

  /// Дата соотношения.
  DateTime get date => DateTime.fromMillisecondsSinceEpoch(timestamp);
}
