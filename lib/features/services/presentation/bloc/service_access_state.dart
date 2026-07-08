import 'package:equatable/equatable.dart';

import '../../domain/entities/service_access_item_entity.dart';
import '../../domain/entities/service_access_type.dart';

enum ServiceAccessListStatus {
  initial,
  loading,
  success,
  failure,
}

enum ServiceAccessDetailStatus {
  initial,
  loading,
  success,
  failure,
}

class ServiceAccessState extends Equatable {
  final ServiceAccessListStatus listStatus;
  final ServiceAccessDetailStatus detailStatus;
  final ServiceAccessSearchType? type;
  final bool hasSearched;
  final bool hasNextPage;
  final List<ServiceAccessItemEntity> items;
  final ServiceAccessItemEntity? detail;
  final String listErrorMessage;
  final String detailErrorMessage;
  final int currentPage;
  final int limit;
  final String query;
  final String category;

  const ServiceAccessState({
    this.listStatus = ServiceAccessListStatus.initial,
    this.detailStatus = ServiceAccessDetailStatus.initial,
    this.type,
    this.hasSearched = false,
    this.hasNextPage = false,
    this.items = const <ServiceAccessItemEntity>[],
    this.detail,
    this.listErrorMessage = '',
    this.detailErrorMessage = '',
    this.currentPage = 1,
    this.limit = 5,
    this.query = '',
    this.category = '',
  });

  factory ServiceAccessState.initial() => const ServiceAccessState();

  bool get isLoadingList => listStatus == ServiceAccessListStatus.loading;
  bool get isLoadingDetail => detailStatus == ServiceAccessDetailStatus.loading;
  bool get hasListError => listErrorMessage.isNotEmpty;
  bool get hasDetailError => detailErrorMessage.isNotEmpty;

  ServiceAccessState copyWith({
    ServiceAccessListStatus? listStatus,
    ServiceAccessDetailStatus? detailStatus,
    ServiceAccessSearchType? type,
    bool? hasSearched,
    bool? hasNextPage,
    List<ServiceAccessItemEntity>? items,
    ServiceAccessItemEntity? detail,
    bool clearDetail = false,
    String? listErrorMessage,
    bool clearListError = false,
    String? detailErrorMessage,
    bool clearDetailError = false,
    int? currentPage,
    int? limit,
    String? query,
    String? category,
  }) {
    return ServiceAccessState(
      listStatus: listStatus ?? this.listStatus,
      detailStatus: detailStatus ?? this.detailStatus,
      type: type ?? this.type,
      hasSearched: hasSearched ?? this.hasSearched,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      items: items ?? this.items,
      detail: clearDetail ? null : detail ?? this.detail,
      listErrorMessage: clearListError ? '' : listErrorMessage ?? this.listErrorMessage,
      detailErrorMessage: clearDetailError ? '' : detailErrorMessage ?? this.detailErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      limit: limit ?? this.limit,
      query: query ?? this.query,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    listStatus,
    detailStatus,
    type,
    hasSearched,
    hasNextPage,
    items,
    detail,
    listErrorMessage,
    detailErrorMessage,
    currentPage,
    limit,
    query,
    category,
  ];
}
