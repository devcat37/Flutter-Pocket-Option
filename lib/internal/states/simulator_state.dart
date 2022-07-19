import 'dart:async';
import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:pocket_option/domain/mocks/mock_pairs.dart';
import 'package:pocket_option/domain/models/currency_pair.dart';
import 'package:pocket_option/domain/models/value_history.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/services/settings.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

part 'simulator_state.g.dart';

/// Тип ставки, вверх/вниз.
enum BetType { up, down }

class SimulatorState = _SimulatorStateBase with _$SimulatorState;

abstract class _SimulatorStateBase with Store {
  static const double _defaultUserBalance = 10000.0;

  @observable
  double userBalance = _defaultUserBalance;

  @observable
  ObservableList<ValueHistory> valuesHistory = ObservableList();

  @observable
  bool isBetting = false;

  @observable
  CurrencyPair pair = mockPair1;

  @observable
  BetType? betType;

  @observable
  int? betAmount;

  @observable
  ValueHistory? betValue;

  @observable
  DateTime? elapsedTime;

  StreamSubscription? subscription;

  @observable
  double? betReward;

  @observable
  bool isLoading = false;

  void changePair(CurrencyPair pair) {
    this.pair = pair;

    _generateInitialData();
  }

  void _generateInitialData() {
    valuesHistory.clear();
    final DateTime now = DateTime.now();

    /// Количество минут которое можно отобразить на экране.
    const int minutesOnScreen = 50;
    for (int i = 0; i < minutesOnScreen; i++) {
      final ValueHistory history = ValueHistory(
        rate: pair.koef + Random().nextDouble() * (0.01 * Random().nextInt(5)) * pair.koef,
        timestamp: now.millisecondsSinceEpoch - 60000 * i,
      );

      valuesHistory.add(history);
    }

    valuesHistory = ObservableList.of(valuesHistory);
  }

  Future<void> setBet(int amount, Duration time, BetType type) async {
    isLoading = true;
    await Future.delayed(aSecond * 3, () => isLoading = false);

    isBetting = true;

    betAmount = amount;
    betType = type;
    betValue = valuesHistory.first;

    elapsedTime = DateTime.fromMillisecondsSinceEpoch(time.inMilliseconds);

    subscription = Stream.periodic(aSecond).listen((_) {
      elapsedTime = DateTime.fromMillisecondsSinceEpoch(elapsedTime!.millisecondsSinceEpoch - 1000);

      if (betType == BetType.up) {
        betReward = (valuesHistory.first.rate - betValue!.rate) * betAmount!;
      } else {
        betReward = (betValue!.rate - valuesHistory.first.rate) * betAmount!;
      }
    });

    Future.delayed(time, () => endBet());
  }

  Future<void> endBet() async {
    userBalance += betReward ?? 0;
    service<Settings>().balance = userBalance;

    betType = null;
    betAmount = null;
    betValue = null;
    betReward = null;

    subscription?.cancel();
    subscription = null;
    isBetting = false;
  }

  Future<void> initialize() async {
    betType = null;
    userBalance = service<Settings>().balance;
    _generateInitialData();

    Stream.periodic(aSecond * 60).listen((_) {
      final DateTime now = DateTime.now();

      final ValueHistory history = ValueHistory(
        rate: valuesHistory.last.rate +
            Random().nextDouble() * (0.01 * Random().nextInt(5)) * pair.koef * (Random().nextBool() ? -1 : 1),
        timestamp: now.millisecondsSinceEpoch,
      );

      valuesHistory.insert(0, history);
      valuesHistory = ObservableList.of(valuesHistory);
    });
  }
}
