import 'package:equatable/equatable.dart';

abstract class LayananEvent extends Equatable {
  const LayananEvent();

  @override
  List<Object> get props => [];
}

class FetchLayanan extends LayananEvent {
  const FetchLayanan();
}
