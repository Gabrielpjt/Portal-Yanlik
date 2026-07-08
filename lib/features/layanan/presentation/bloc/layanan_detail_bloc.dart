import 'package:flutter_bloc/flutter_bloc.dart';
import 'layanan_detail_event.dart';
import 'layanan_detail_state.dart';

abstract class LayananRepository {
  Future<(dynamic, dynamic)> getLayananById(String id);
}

class LayananDetailBloc extends Bloc<LayananDetailEvent, LayananDetailState> {
  final LayananRepository _repository;

  LayananDetailBloc(this._repository) : super(const LayananDetailState()) {
    on<FetchLayananDetail>(_onFetchLayananDetail);
  }

  Future<void> _onFetchLayananDetail(
    FetchLayananDetail event,
    Emitter<LayananDetailState> emit,
  ) async {
    emit(state.copyWith(status: LayananDetailStatus.loading));

    final (layanan, failure) = await _repository.getLayananById(event.id.toString());

    if (failure != null) {
      emit(
        state.copyWith(
          status: LayananDetailStatus.error,
          errorMessage: failure.message,
        ),
      );
    } else {
      emit(
        state.copyWith(status: LayananDetailStatus.loaded, layanan: layanan),
      );
    }
  }
}
