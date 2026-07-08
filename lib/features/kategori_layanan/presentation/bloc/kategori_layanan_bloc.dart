import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/kategori_layanan_repository.dart';
import 'kategori_layanan_event.dart';
import 'kategori_layanan_state.dart';

class KategoriLayananBloc extends Bloc<KategoriLayananEvent, KategoriLayananState> {
  final KategoriLayananRepository _repository;

  KategoriLayananBloc(this._repository) : super(const KategoriLayananState()) {
    on<FetchKategoriLayanan>(_onFetchKategoriLayanan);
  }

  Future<void> _onFetchKategoriLayanan(
      FetchKategoriLayanan event, Emitter<KategoriLayananState> emit) async {
    emit(state.copyWith(status: KategoriLayananStatus.loading));

    final (items, failure) = await _repository.getKategoriLayanan();

    if (failure != null) {
      emit(state.copyWith(
        status: KategoriLayananStatus.error,
        errorMessage: failure.message,
      ));
    } else {
      emit(state.copyWith(
        status: KategoriLayananStatus.loaded,
        items: items ?? [],
      ));
    }
  }
}
