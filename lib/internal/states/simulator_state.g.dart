// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulator_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SimulatorState on _SimulatorStateBase, Store {
  late final _$userBalanceAtom =
      Atom(name: '_SimulatorStateBase.userBalance', context: context);

  @override
  double get userBalance {
    _$userBalanceAtom.reportRead();
    return super.userBalance;
  }

  @override
  set userBalance(double value) {
    _$userBalanceAtom.reportWrite(value, super.userBalance, () {
      super.userBalance = value;
    });
  }

  late final _$valuesHistoryAtom =
      Atom(name: '_SimulatorStateBase.valuesHistory', context: context);

  @override
  ObservableList<ValueHistory> get valuesHistory {
    _$valuesHistoryAtom.reportRead();
    return super.valuesHistory;
  }

  @override
  set valuesHistory(ObservableList<ValueHistory> value) {
    _$valuesHistoryAtom.reportWrite(value, super.valuesHistory, () {
      super.valuesHistory = value;
    });
  }

  late final _$isBettingAtom =
      Atom(name: '_SimulatorStateBase.isBetting', context: context);

  @override
  bool get isBetting {
    _$isBettingAtom.reportRead();
    return super.isBetting;
  }

  @override
  set isBetting(bool value) {
    _$isBettingAtom.reportWrite(value, super.isBetting, () {
      super.isBetting = value;
    });
  }

  late final _$pairAtom =
      Atom(name: '_SimulatorStateBase.pair', context: context);

  @override
  CurrencyPair get pair {
    _$pairAtom.reportRead();
    return super.pair;
  }

  @override
  set pair(CurrencyPair value) {
    _$pairAtom.reportWrite(value, super.pair, () {
      super.pair = value;
    });
  }

  late final _$betTypeAtom =
      Atom(name: '_SimulatorStateBase.betType', context: context);

  @override
  BetType? get betType {
    _$betTypeAtom.reportRead();
    return super.betType;
  }

  @override
  set betType(BetType? value) {
    _$betTypeAtom.reportWrite(value, super.betType, () {
      super.betType = value;
    });
  }

  late final _$betAmountAtom =
      Atom(name: '_SimulatorStateBase.betAmount', context: context);

  @override
  int? get betAmount {
    _$betAmountAtom.reportRead();
    return super.betAmount;
  }

  @override
  set betAmount(int? value) {
    _$betAmountAtom.reportWrite(value, super.betAmount, () {
      super.betAmount = value;
    });
  }

  late final _$betValueAtom =
      Atom(name: '_SimulatorStateBase.betValue', context: context);

  @override
  ValueHistory? get betValue {
    _$betValueAtom.reportRead();
    return super.betValue;
  }

  @override
  set betValue(ValueHistory? value) {
    _$betValueAtom.reportWrite(value, super.betValue, () {
      super.betValue = value;
    });
  }

  late final _$elapsedTimeAtom =
      Atom(name: '_SimulatorStateBase.elapsedTime', context: context);

  @override
  DateTime? get elapsedTime {
    _$elapsedTimeAtom.reportRead();
    return super.elapsedTime;
  }

  @override
  set elapsedTime(DateTime? value) {
    _$elapsedTimeAtom.reportWrite(value, super.elapsedTime, () {
      super.elapsedTime = value;
    });
  }

  late final _$betRewardAtom =
      Atom(name: '_SimulatorStateBase.betReward', context: context);

  @override
  double? get betReward {
    _$betRewardAtom.reportRead();
    return super.betReward;
  }

  @override
  set betReward(double? value) {
    _$betRewardAtom.reportWrite(value, super.betReward, () {
      super.betReward = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_SimulatorStateBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  @override
  String toString() {
    return '''
userBalance: ${userBalance},
valuesHistory: ${valuesHistory},
isBetting: ${isBetting},
pair: ${pair},
betType: ${betType},
betAmount: ${betAmount},
betValue: ${betValue},
elapsedTime: ${elapsedTime},
betReward: ${betReward},
isLoading: ${isLoading}
    ''';
  }
}
