import 'package:mobx/mobx.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

part 'subscription_state.g.dart';

class SubscriptionState = _SubscriptionStateBase with _$SubscriptionState;

abstract class _SubscriptionStateBase with Store {
  @observable
  bool subscribed = false;

  Future<bool> subscribe() async {
    await Future.delayed(aSecond * 2);

    subscribed = true;
    return true;
  }

  Future<bool> restore() async {
    await Future.delayed(aSecond * 2);

    subscribed = true;
    return true;
  }
}
