import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/service_detail_repository.dart';
import 'service_detail_event.dart';
import 'service_detail_state.dart';

class ServiceDetailBloc
    extends Bloc<ServiceDetailEvent, ServiceDetailState> {
  final ServiceDetailRepository repository;

  ServiceDetailBloc({
    required this.repository,
  }) : super(const ServiceDetailState()) {
    on<FetchServiceDetail>(_onFetchServiceDetail);
  }

  Future<void> _onFetchServiceDetail(
      FetchServiceDetail event,
      Emitter<ServiceDetailState> emit,
      ) async {
    emit(
      state.copyWith(
        status: ServiceDetailStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final detail = await repository.getDetail(event.id);

      emit(
        state.copyWith(
          status: ServiceDetailStatus.success,
          detail: detail,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ServiceDetailStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}