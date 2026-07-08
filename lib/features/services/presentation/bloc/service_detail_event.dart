import 'package:equatable/equatable.dart';

abstract class ServiceDetailEvent extends Equatable {
  const ServiceDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchServiceDetail extends ServiceDetailEvent {
  final int id;

  const FetchServiceDetail(this.id);

  @override
  List<Object?> get props => [id];
}