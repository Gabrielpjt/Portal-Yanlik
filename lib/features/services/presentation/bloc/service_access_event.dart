import 'package:equatable/equatable.dart';

import '../../domain/entities/service_access_type.dart';

abstract class ServiceAccessEvent extends Equatable {
  const ServiceAccessEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ServiceAccessSearchRequested extends ServiceAccessEvent {
  final ServiceAccessSearchType type;
  final String token;
  final int page;
  final int limit;
  final String query;
  final String category;

  const ServiceAccessSearchRequested({
    required this.type,
    required this.token,
    required this.page,
    required this.limit,
    this.query = '',
    this.category = '',
  });

  @override
  List<Object?> get props => <Object?>[
    type,
    token,
    page,
    limit,
    query,
    category,
  ];
}

class ServiceAccessDetailRequested extends ServiceAccessEvent {
  final ServiceAccessSearchType type;
  final String token;
  final String id;

  const ServiceAccessDetailRequested({
    required this.type,
    required this.token,
    required this.id,
  });

  @override
  List<Object?> get props => <Object?>[
    type,
    token,
    id,
  ];
}

class ServiceAccessSearchCleared extends ServiceAccessEvent {
  const ServiceAccessSearchCleared();
}

class ServiceAccessDetailCleared extends ServiceAccessEvent {
  const ServiceAccessDetailCleared();
}
