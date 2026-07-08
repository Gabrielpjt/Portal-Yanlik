import 'package:equatable/equatable.dart';

import '../../domain/entities/service_detail_entity.dart';

enum ServiceDetailStatus {
  initial,
  loading,
  success,
  error,
}

class ServiceDetailState extends Equatable {
  final ServiceDetailStatus status;
  final ServiceDetailEntity? detail;
  final String errorMessage;

  const ServiceDetailState({
    this.status = ServiceDetailStatus.initial,
    this.detail,
    this.errorMessage = '',
  });

  ServiceDetailState copyWith({
    ServiceDetailStatus? status,
    ServiceDetailEntity? detail,
    String? errorMessage,
  }) {
    return ServiceDetailState(
      status: status ?? this.status,
      detail: detail ?? this.detail,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    detail,
    errorMessage,
  ];
}