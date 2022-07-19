import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Settings {
  static const String appName = 'Pocket Option';

  /// Зашифрованное хранилище локальных данных.
  late FlutterSecureStorage _storage;
  late Map<String, String> _secureValues;

  static const balanceKey = 'balance';
  static const lastTimeSignKey = 'lastTimeSign';

  Future initStorage() async {
    _storage = const FlutterSecureStorage();
    _secureValues = await _storage.readAll();
  }

  double get balance => double.tryParse(_secureValues[balanceKey] ?? '') ?? 10000.0;
  set balance(double nBalance) {
    _secureValues[balanceKey] = nBalance.toString();
    _storage.write(key: balanceKey, value: nBalance.toString());
  }

  DateTime get lastTimeSign => DateTime.tryParse(_secureValues[lastTimeSignKey] ?? '') ?? DateTime.now();
  set lastTimeSign(DateTime nLastTime) {
    _secureValues[lastTimeSignKey] = nLastTime.toIso8601String();
    _storage.write(key: lastTimeSignKey, value: nLastTime.toIso8601String());
  }
}
