import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/informasi_layanan_repository.dart';
import 'informasi_layanan_event.dart';
import 'informasi_layanan_state.dart';

/// Bloc that manages the informasi layanan list on the home page.
///
/// Events:
/// - [FetchInformasiLayanan]: Load the list (initial load).
/// - [RefreshInformasiLayanan]: Reset and reload.
class InformasiLayananBloc
    extends Bloc<InformasiLayananEvent, InformasiLayananState> {
  final InformasiLayananRepository _repository;

  InformasiLayananBloc(this._repository)
      : super(const InformasiLayananState()) {
    on<FetchInformasiLayanan>(_onFetch);
    on<RefreshInformasiLayanan>(_onRefresh);
  }

  Future<void> _onFetch(
    FetchInformasiLayanan event,
    Emitter<InformasiLayananState> emit,
  ) async {
    emit(state.copyWith(status: InformasiLayananStatus.loading));

    final (items, failure) = await _repository.getInformasiLayanan(
      page: 1,
      limit: 5,
    );

    if (failure != null) {
      emit(state.copyWith(
        status: InformasiLayananStatus.error,
        errorMessage: failure.message,
      ));
      return;
    }

    emit(state.copyWith(
      status: InformasiLayananStatus.loaded,
      items: items,
    ));
  }

  Future<void> _onRefresh(
    RefreshInformasiLayanan event,
    Emitter<InformasiLayananState> emit,
  ) async {
    emit(const InformasiLayananState(
        status: InformasiLayananStatus.loading));

    final (items, failure) = await _repository.getInformasiLayanan(
      page: 1,
      limit: 5,
    );

    if (failure != null) {
      emit(state.copyWith(
        status: InformasiLayananStatus.error,
        errorMessage: failure.message,
      ));
      return;
    }

    emit(state.copyWith(
      status: InformasiLayananStatus.loaded,
      items: items,
    ));
  }
}
