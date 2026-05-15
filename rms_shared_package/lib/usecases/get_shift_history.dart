import '../models/shift_models/shift_session.dart';
import '../repositories/shift_repository.dart';

class GetShiftHistory {
  final ShiftRepository repository;

  GetShiftHistory(this.repository);

  Future<List<ShiftSession>> call(String staffId, {int limit = 10}) {
    return repository.getShiftHistory(staffId, limit: limit);
  }
}
