class ShiftSchedule {
  final String id;
  final String staffId;
  final List<String> days;
  final int startMinutes;
  final int endMinutes;
  final int graceMinutes;
  final bool isEnabled;

  const ShiftSchedule({
    required this.id,
    required this.staffId,
    required this.days,
    required this.startMinutes,
    required this.endMinutes,
    required this.graceMinutes,
    required this.isEnabled,
  });

  factory ShiftSchedule.fromMap(Map<String, dynamic> map, String id) {
    return ShiftSchedule(
      id: id,
      staffId: map['staffId'] as String? ?? '',
      days: ((map['days'] as List?) ?? const <dynamic>[])
          .map((day) => day.toString().toLowerCase())
          .toList(),
      startMinutes: (map['startMinutes'] as num?)?.toInt() ?? 0,
      endMinutes: (map['endMinutes'] as num?)?.toInt() ?? 0,
      graceMinutes: (map['graceMinutes'] as num?)?.toInt() ?? 0,
      isEnabled: map['isEnabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'staffId': staffId,
      'days': days,
      'startMinutes': startMinutes,
      'endMinutes': endMinutes,
      'graceMinutes': graceMinutes,
      'isEnabled': isEnabled,
    };
  }

  bool appliesTo(DateTime date) {
    if (!isEnabled) return false;
    final weekday = _weekdayKey(date);
    return days.isEmpty || days.contains(weekday);
  }

  DateTime startFor(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      startMinutes ~/ 60,
      startMinutes % 60,
    );
  }

  DateTime endFor(DateTime date) {
    final base = DateTime(
      date.year,
      date.month,
      date.day,
      endMinutes ~/ 60,
      endMinutes % 60,
    );
    if (endMinutes >= startMinutes) return base;
    return base.add(const Duration(days: 1));
  }

  static String _weekdayKey(DateTime date) {
    const weekdays = <String>[
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];
    return weekdays[date.weekday - 1];
  }
}
