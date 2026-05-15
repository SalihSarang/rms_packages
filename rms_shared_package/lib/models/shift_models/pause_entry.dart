class PauseEntry {
  final DateTime pausedAt;
  final DateTime? resumedAt;
  final int durationMinutes;

  const PauseEntry({
    required this.pausedAt,
    this.resumedAt,
    required this.durationMinutes,
  });

  factory PauseEntry.fromMap(Map<String, dynamic> map) {
    return PauseEntry(
      pausedAt: DateTime.fromMillisecondsSinceEpoch(map['pausedAt'] as int),
      resumedAt: map['resumedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['resumedAt'] as int)
          : null,
      durationMinutes: (map['durationMinutes'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pausedAt': pausedAt.millisecondsSinceEpoch,
      'resumedAt': resumedAt?.millisecondsSinceEpoch,
      'durationMinutes': durationMinutes,
    };
  }

  PauseEntry copyWith({
    DateTime? pausedAt,
    DateTime? resumedAt,
    int? durationMinutes,
  }) {
    return PauseEntry(
      pausedAt: pausedAt ?? this.pausedAt,
      resumedAt: resumedAt ?? this.resumedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
    );
  }
}
