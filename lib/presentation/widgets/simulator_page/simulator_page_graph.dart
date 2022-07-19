import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_option/domain/models/value_history.dart';
import 'package:pocket_option/internal/states/simulator_state.dart';
import 'package:pocket_option/presentation/widgets/simulator_page/graph_drawer.dart';

class SimulatorPageGraph extends StatelessWidget {
  const SimulatorPageGraph({
    Key? key,
    this.valuesHistory = const [],
    this.betValue,
    this.betType,
  }) : super(key: key);

  final List<ValueHistory> valuesHistory;
  final ValueHistory? betValue;
  final BetType? betType;

  Widget _buildGraph(BuildContext context) {
    return CustomPaint(
      painter: GraphDrawer(
        height: 362.h,
        width: MediaQuery.of(context).size.width,
        currentTime: DateTime.now(),
        valueHistory: valuesHistory,
        betValue: betValue,
        betType: betType,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg.png',
          height: 362.h,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        _buildGraph(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _buildContent(context),
    );
  }
}
