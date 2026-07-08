import 'package:equatable/equatable.dart';

import 'service_access_type.dart';

abstract class ServiceAccessItemEntity extends Equatable {
  final ServiceAccessSearchType type;
  final String id;

  const ServiceAccessItemEntity({
    required this.type,
    required this.id,
  });

  Map<String, dynamic> toMap();
}
