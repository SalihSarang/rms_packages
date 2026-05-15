import '../models/shift_models/shift_session.dart';
import '../repositories/shift_repository.dart';

class GetCurrentShiftSession {
  final ShiftRepository repository;

  GetCurrentShiftSession(this.repository);

  Future<ShiftSession?> call(String staffId) {
    return repository.getCurrentShiftSession(staffId);
  }
}
