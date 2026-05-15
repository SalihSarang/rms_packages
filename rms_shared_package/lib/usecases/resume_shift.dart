import '../models/shift_models/shift_session.dart';
import '../repositories/shift_repository.dart';

class ResumeShift {
  final ShiftRepository repository;

  ResumeShift(this.repository);

  Future<ShiftSession> call(String staffId) {
    return repository.resumeShift(staffId);
  }
}
