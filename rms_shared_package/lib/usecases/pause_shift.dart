import '../models/shift_models/shift_session.dart';
import '../repositories/shift_repository.dart';

class PauseShift {
  final ShiftRepository repository;

  PauseShift(this.repository);

  Future<ShiftSession> call(String staffId) {
    return repository.pauseShift(staffId);
  }
}
