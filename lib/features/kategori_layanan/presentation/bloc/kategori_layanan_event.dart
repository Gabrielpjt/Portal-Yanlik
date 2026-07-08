import 'package:equatable/equatable.dart';

abstract class KategoriLayananEvent extends Equatable {
  const KategoriLayananEvent();

  @override
  List<Object> get props => [];
}

class FetchKategoriLayanan extends KategoriLayananEvent {
  const FetchKategoriLayanan();
}
