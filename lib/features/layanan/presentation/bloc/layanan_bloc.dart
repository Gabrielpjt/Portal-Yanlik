import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/layanan_repository.dart';
import 'layanan_event.dart';
import 'layanan_state.dart';

class LayananBloc extends Bloc<LayananEvent, LayananState> {
  final LayananRepository _repository;

  LayananBloc(this._repository) : super(const LayananState()) {
    on<FetchLayanan>(_onFetchLayanan);
  }

  Future<void> _onFetchLayanan(
      FetchLayanan event, Emitter<LayananState> emit) async {
    emit(state.copyWith(status: LayananStatus.loading));

    final (items, failure) = await _repository.getLayanan();

    if (failure != null) {
      emit(state.copyWith(
        status: LayananStatus.error,
        errorMessage: failure.message,
      ));
    } else {
      emit(state.copyWith(
        status: LayananStatus.loaded,
        items: items ?? [],
      ));
    }
  }
}
