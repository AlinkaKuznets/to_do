import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/domain/model/case.dart';
import 'package:to_do/domain/repository/case_repository.dart';

class ShowCasesCubit extends Cubit<ShowCasesState> {
  final CaseRepository _showCasesRepository;

  ShowCasesCubit(this._showCasesRepository) : super(ShowCaseStateLoading());

  Future<void> loadData() async {
    try {
      if (state is! ShowCasesStateReady) {
        emit(ShowCaseStateLoading());
      }

      final data = await _showCasesRepository.getCases();

      emit(ShowCasesStateReady(data: data));
    } catch (err, st) {
      emit(ShowCasesStateError(error: err, st: st));
    }
  }
}

sealed class ShowCasesState {}

class ShowCaseStateLoading extends ShowCasesState {}

class ShowCasesStateError extends ShowCasesState {
  Object? error;
  final StackTrace? st;

  ShowCasesStateError({required this.error, required this.st});
}

class ShowCasesStateReady extends ShowCasesState {
  final List<Case> data;

  ShowCasesStateReady({required this.data});
}
