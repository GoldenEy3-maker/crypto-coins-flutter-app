import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/core/utils/ticker.dart";
import "package:flutter_application_1/features/timer/presentation/blocs/timer_bloc.dart";
import "package:flutter_application_1/features/timer/presentation/views/timer_view.dart";
import "package:flutter_bloc/flutter_bloc.dart";

@RoutePage()
class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(ticker: const Ticker()),
      child: const TimerView(),
    );
  }
}
