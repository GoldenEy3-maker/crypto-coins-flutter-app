enum TimeFormatterFormat {
  // ignore: constant_identifier_names
  MM_SS("mm:ss"),
  // ignore: constant_identifier_names
  HH_MM_SS("hh:mm:ss");

  final String pattern;

  const TimeFormatterFormat(this.pattern);
}

class TimeFormatter {
  static String formatSeconds(
    int duration, {
    TimeFormatterFormat format = .MM_SS,
  }) {
    switch (format) {
      case .MM_SS:
        final minutes = _getMinutesFromSeconds(
          duration,
        ).toString().padLeft(2, "0");
        final seconds = _getSecondsFromSeconds(
          duration,
        ).toString().padLeft(2, "0");
        return format.pattern
            .replaceAll("mm", minutes)
            .replaceAll("ss", seconds);
      case .HH_MM_SS:
        final hours = _getHoursFromSeconds(duration).toString().padLeft(2, "0");
        final minutes = _getMinutesFromSeconds(
          duration,
        ).toString().padLeft(2, "0");
        final seconds = _getSecondsFromSeconds(
          duration,
        ).toString().padLeft(2, "0");
        return format.pattern
            .replaceAll("hh", hours)
            .replaceAll("mm", minutes)
            .replaceAll("ss", seconds);
    }
  }

  static int _getMinutesFromSeconds(int seconds) =>
      ((seconds / 60) % 60).floor();
  static int _getHoursFromSeconds(int seconds) => (seconds / 3600).floor();
  static int _getSecondsFromSeconds(int seconds) => (seconds % 60).floor();
}
