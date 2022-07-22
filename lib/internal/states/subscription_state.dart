import 'package:mobx/mobx.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';
import 'package:pocket_option/main.dart';

part 'subscription_state.g.dart';

class SubscriptionState = _SubscriptionStateBase with _$SubscriptionState;

abstract class _SubscriptionStateBase with Store {
  @observable
  bool subscribed = false;

  Future<bool> subscribe() async {
    await Future.delayed(aSecond * 2);

    return await purchase();

    // subscribed = true;
    // return true;
  }

  Future<bool> restorePurchase() async {
    await Future.delayed(aSecond * 2);

    return await restore();

    // subscribed = true;
    // return true;
  }
}
