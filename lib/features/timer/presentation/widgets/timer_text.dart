import "package:flutter/material.dart";
import "package:flutter_application_1/core/utils/time_formatter.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../blocs/timer_bloc.dart";

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    return Text(
      TimeFormatter.formatSeconds(duration, format: .HH_MM_SS),
      style: theme.textTheme.headlineLarge?.copyWith(fontWeight: .w500),
    );
  }
}
