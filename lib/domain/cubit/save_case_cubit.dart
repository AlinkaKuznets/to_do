import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/domain/repository/case_repository.dart';

class SaveCaseCubit extends Cubit<SaveCaseState> {
  final CaseRepository _addNewCase;

  SaveCaseCubit(this._addNewCase) : super(SaveCaseStateLoading());

  Future<void> addCase(String title, DateTime time, String description) async {
    try {
      emit(SaveCaseStateLoading());

      await _addNewCase.addCase(title, time, description);

      emit(CaseStateReady());
    } catch (err, st) {
      emit(
        SaveCaseStateError(error: err, st: st),
      );
    }
  }
}

sealed class SaveCaseState {}

class SaveCaseStateLoading extends SaveCaseState {}

class SaveCaseStateError extends SaveCaseState {
  Object error;
  final StackTrace st;

  SaveCaseStateError({required this.error, required this.st});
}

class CaseStateReady extends SaveCaseState {}
