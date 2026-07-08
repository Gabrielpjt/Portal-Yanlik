import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/repositories/service_access_repository.dart';
import 'service_access_event.dart';
import 'service_access_state.dart';

class ServiceAccessBloc extends Bloc<ServiceAccessEvent, ServiceAccessState> {
  final ServiceAccessRepository repository;

  ServiceAccessBloc({
    required this.repository,
  }) : super(ServiceAccessState.initial()) {
    on<ServiceAccessSearchRequested>(_onSearchRequested);
    on<ServiceAccessDetailRequested>(_onDetailRequested);
    on<ServiceAccessSearchCleared>(_onSearchCleared);
    on<ServiceAccessDetailCleared>(_onDetailCleared);
  }

  Future<void> _onSearchRequested(
      ServiceAccessSearchRequested event,
      Emitter<ServiceAccessState> emit,
      ) async {
    if (event.token.trim().isEmpty) {
      emit(
        state.copyWith(
          listStatus: ServiceAccessListStatus.failure,
          type: event.type,
          hasSearched: true,
          items: const [],
          hasNextPage: false,
          currentPage: event.page,
          limit: event.limit,
          query: event.query,
          category: event.category,
          listErrorMessage: _loginRequiredMessage,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        listStatus: ServiceAccessListStatus.loading,
        type: event.type,
        hasSearched: true,
        currentPage: event.page,
        limit: event.limit,
        query: event.query,
        category: event.category,
        clearListError: true,
      ),
    );

    try {
      final items = await repository.search(
        type: event.type,
        token: event.token,
        page: event.page,
        limit: event.limit,
        query: event.query,
        category: event.category,
      );

      emit(
        state.copyWith(
          listStatus: ServiceAccessListStatus.success,
          items: items,
          hasNextPage: items.length >= event.limit,
          clearListError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          listStatus: ServiceAccessListStatus.failure,
          items: const [],
          hasNextPage: false,
          listErrorMessage: _errorMessage(error),
        ),
      );
    }
  }

  Future<void> _onDetailRequested(
      ServiceAccessDetailRequested event,
      Emitter<ServiceAccessState> emit,
      ) async {
    if (event.token.trim().isEmpty) {
      emit(
        state.copyWith(
          detailStatus: ServiceAccessDetailStatus.failure,
          type: event.type,
          clearDetail: true,
          detailErrorMessage: _loginRequiredMessage,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        detailStatus: ServiceAccessDetailStatus.loading,
        type: event.type,
        clearDetailError: true,
      ),
    );

    try {
      final detail = await repository.getDetail(
        type: event.type,
        token: event.token,
        id: event.id,
      );

      emit(
        state.copyWith(
          detailStatus: ServiceAccessDetailStatus.success,
          detail: detail,
          clearDetailError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          detailStatus: ServiceAccessDetailStatus.failure,
          clearDetail: true,
          detailErrorMessage: _errorMessage(error),
        ),
      );
    }
  }

  void _onSearchCleared(
      ServiceAccessSearchCleared event,
      Emitter<ServiceAccessState> emit,
      ) {
    emit(ServiceAccessState.initial());
  }

  void _onDetailCleared(
      ServiceAccessDetailCleared event,
      Emitter<ServiceAccessState> emit,
      ) {
    emit(
      state.copyWith(
        detailStatus: ServiceAccessDetailStatus.initial,
        clearDetail: true,
        clearDetailError: true,
      ),
    );
  }

  static const String _loginRequiredMessage =
      'Silakan masuk terlebih dahulu untuk menggunakan layanan ini.';

  String _errorMessage(Object error) {
    if (error is Failure) {
      return _friendlyErrorMessage(error.message);
    }

    return _friendlyErrorMessage(
      error.toString().replaceFirst('Exception: ', ''),
    );
  }

  String _friendlyErrorMessage(String message) {
    final normalizedMessage = message.toLowerCase();

    if (normalizedMessage.contains('unauthorized') ||
        normalizedMessage.contains('401')) {
      return 'Sesi Anda telah berakhir atau belum valid. Silakan masuk kembali.';
    }

    return message;
  }
}
