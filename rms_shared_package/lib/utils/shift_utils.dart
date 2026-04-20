import '../enums/enums.dart';
import '../models/shift_models/pause_entry.dart';
import '../models/shift_models/shift_schedule.dart';
import '../models/shift_models/shift_session.dart';

class ShiftUtils {
  static int calculateWorkedMinutes({
    required DateTime? start,
    required DateTime? end,
    required List<PauseEntry> pauseEntries,
  }) {
    if (start == null || end == null) return 0;
    final totalMinutes = end.difference(start).inMinutes;
    final pausedMinutes = pauseEntries.fold<int>(
      0,
      (sum, entry) => sum + entry.durationMinutes,
    );
    final worked = totalMinutes - pausedMinutes;
    return worked < 0 ? 0 : worked;
  }

  static int calculateLiveWorkedMinutes(ShiftSession? session) {
    if (session == null || session.actualStart == null) return 0;
    final now = DateTime.now();
    final pauses = session.pauseEntries.map((entry) {
      if (entry.resumedAt != null) return entry;
      return entry.copyWith(
        resumedAt: now,
        durationMinutes: now.difference(entry.pausedAt).inMinutes,
      );
    }).toList();
    return calculateWorkedMinutes(
      start: session.actualStart,
      end: session.actualEnd ?? now,
      pauseEntries: pauses,
    );
  }

  static String formatMinutes(int minutes) {
    final safeMinutes = minutes < 0 ? 0 : minutes;
    final hours = safeMinutes ~/ 60;
    final remainder = safeMinutes % 60;
    return '${hours}h ${remainder}m';
  }

  static String formatTime(DateTime? time) {
    if (time == null) return '--:--';
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final suffix = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $suffix';
  }

  static String formatSchedule(ShiftSchedule? schedule, {DateTime? date}) {
    if (schedule == null) return 'No shift assigned';
    final targetDate = date ?? DateTime.now();
    return '${formatTime(schedule.startFor(targetDate))} - ${formatTime(schedule.endFor(targetDate))}';
  }

  static String formatSessionWindow(ShiftSession? session) {
    if (session == null) return 'Not started';
    final start = formatTime(session.actualStart);
    final end = session.actualEnd != null
        ? formatTime(session.actualEnd)
        : 'Now';
    return '$start - $end';
  }

  static String latenessLabel(ShiftSession? session, ShiftSchedule? schedule) {
    if (schedule == null) return '';
    final targetDate = session?.actualStart ?? DateTime.now();
    final scheduledStart = schedule.startFor(targetDate);
    final actualStart = session?.actualStart;
    if (actualStart == null) {
      final graceCutoff = scheduledStart.add(
        Duration(minutes: schedule.graceMinutes),
      );
      if (DateTime.now().isAfter(graceCutoff)) {
        return 'Missed start window';
      }
      return 'Starts at ${formatTime(scheduledStart)}';
    }
    final minutes = actualStart.difference(scheduledStart).inMinutes;
    if (minutes > 0) return 'Late by ${minutes}m';
    if (minutes < 0) return 'Early by ${minutes.abs()}m';
    return 'On time';
  }

  static String formatStatus(ShiftStatus status) {
    switch (status) {
      case ShiftStatus.notStarted:
        return 'Not Started';
      case ShiftStatus.active:
        return 'Active';
      case ShiftStatus.paused:
        return 'Paused';
      case ShiftStatus.ended:
        return 'Ended';
      case ShiftStatus.missed:
        return 'Missed';
    }
  }

  static ShiftStatus derivedStatus({
    required ShiftSession? session,
    required ShiftSchedule? schedule,
  }) {
    if (session != null) return session.status;
    if (schedule == null) return ShiftStatus.notStarted;
    final cutoff = schedule
        .startFor(DateTime.now())
        .add(Duration(minutes: schedule.graceMinutes));
    if (DateTime.now().isAfter(cutoff)) {
      return ShiftStatus.missed;
    }
    return ShiftStatus.notStarted;
  }

  static String dateKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
