import 'package:equatable/equatable.dart';

abstract class InformasiLayananEvent extends Equatable {
  const InformasiLayananEvent();

  @override
  List<Object?> get props => [];
}

/// Load the list of informasi layanan (initial load or refresh).
class FetchInformasiLayanan extends InformasiLayananEvent {
  const FetchInformasiLayanan();
}

/// Refresh the informasi layanan list from scratch.
class RefreshInformasiLayanan extends InformasiLayananEvent {
  const RefreshInformasiLayanan();
}
