import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_option/internal/services/service_locator.dart';
import 'package:pocket_option/internal/states/simulator_state.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';
import 'package:pocket_option/presentation/widgets/simulator_page/simulator_page_actions.dart';
import 'package:pocket_option/presentation/widgets/simulator_page/simulator_page_graph.dart';
import 'package:pocket_option/presentation/widgets/simulator_page/simulator_page_header.dart';

class SimulatorPageView extends StatelessWidget {
  const SimulatorPageView({Key? key}) : super(key: key);

  SimulatorState get state => service<SimulatorState>();

  Widget _buildHeader(BuildContext context) {
    return SimulatorPageHeader(
      balance: state.userBalance,
      pair: state.pair,
      onChangePair: state.changePair,
      canChangePair: !state.isBetting && !state.isLoading,
    );
  }

  Widget _buildGraph(BuildContext context) {
    return SimulatorPageGraph(
      valuesHistory: state.valuesHistory,
      betValue: state.betValue,
      betType: state.betType,
    );
  }

  Widget _buildBottomPart(BuildContext context) {
    return SimulatorPageActions(
      isAwaitingForEnd: state.isBetting,
      isLoading: state.isLoading,
      reward: state.betReward,
      onBet: state.setBet,
      time: state.elapsedTime,
    );
  }

  Widget _buildLoader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: blackColor.withOpacity(0.4),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation(whiteColor),
          strokeWidth: 4.r,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Observer(
      builder: (context) => Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                _buildGraph(context),
                const Spacer(),
                _buildBottomPart(context),
                SizedBox(height: 16.h + MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
          if (state.isLoading) _buildLoader(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }
}
