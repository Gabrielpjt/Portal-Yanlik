import 'package:equatable/equatable.dart';

abstract class LayananDetailEvent extends Equatable {
  const LayananDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchLayananDetail extends LayananDetailEvent {
  final int id;

  const FetchLayananDetail(this.id);

  @override
  List<Object> get props => [id];
}
