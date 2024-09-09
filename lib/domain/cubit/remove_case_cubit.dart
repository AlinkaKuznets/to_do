import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/domain/repository/case_repository.dart';

class RemoveCaseCubit extends Cubit<RemoveCaseState> {
  final CaseRepository _removeCaseRepository;

  RemoveCaseCubit(this._removeCaseRepository) : super(RemoveCaseStateLoading());

  Future<void> removeItem(String id) async {
    try {
      emit(RemoveCaseStateLoading());
      await _removeCaseRepository.removeCase(id);
      emit(RemoveCaseStateReady());
    } catch (err, st) {
      emit(RemoveCaseStateError(error: err, st: st));
    }
  }
}

sealed class RemoveCaseState {}

class RemoveCaseStateLoading extends RemoveCaseState {}

class RemoveCaseStateError extends RemoveCaseState {
  Object? error;
  final StackTrace? st;

  RemoveCaseStateError({required this.error, required this.st});
}

class RemoveCaseStateReady extends RemoveCaseState {}
