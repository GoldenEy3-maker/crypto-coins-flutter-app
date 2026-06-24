import "package:flutter/material.dart";

import "../widgets/timer_actions.dart";
import "../widgets/timer_text.dart";

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Padding(
              padding: .symmetric(horizontal: 100),
              child: Center(child: TimerText()),
            ),
            Padding(padding: .only(top: 24), child: TimerActions()),
          ],
        ),
      ],
    );
  }
}
