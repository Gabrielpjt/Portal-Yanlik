import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/repositories/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _repository;

  SearchBloc(this._repository) : super(const SearchInitial()) {
    on<SearchAllEvent>(_onSearchAll);
    on<SearchLayananEvent>(_onSearchLayanan);
    on<SearchInformasiLayananEvent>(_onSearchInformasiLayanan);
    on<ClearSearchEvent>(_onClearSearch);
    on<ChangeSearchFilterEvent>(_onChangeFilter);
  }

  Future<void> _onSearchAll(
    SearchAllEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(const SearchInitial());
      return;
    }

    if (event.query.trim().length < 2) {
      emit(const SearchError('Kata kunci minimal 2 karakter'));
      return;
    }

    emit(const SearchLoading());

    try {
      final results = await _repository.searchAll(
        event.query,
        page: event.page,
        limit: event.limit,
      );

      if (results.isEmpty) {
        emit(SearchEmpty(event.query));
      } else {
        emit(SearchSuccess(
          results: results,
          currentFilter: SearchFilter.all,
          query: event.query,
        ));
      }
    } catch (e) {
      Logger.log('Search error: $e', tag: 'SearchBloc');
      emit(SearchError('Gagal melakukan pencarian: ${e.toString()}'));
    }
  }

  Future<void> _onSearchLayanan(
    SearchLayananEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(const SearchInitial());
      return;
    }

    if (event.query.trim().length < 2) {
      emit(const SearchError('Kata kunci minimal 2 karakter'));
      return;
    }

    emit(const SearchLoading());

    try {
      final results = await _repository.searchLayanan(
        event.query,
        page: event.page,
        limit: event.limit,
      );

      if (results.isEmpty) {
        emit(SearchEmpty(event.query));
      } else {
        emit(SearchSuccess(
          results: results,
          currentFilter: SearchFilter.layanan,
          query: event.query,
        ));
      }
    } catch (e) {
      Logger.log('Search layanan error: $e', tag: 'SearchBloc');
      emit(SearchError('Gagal mencari layanan: ${e.toString()}'));
    }
  }

  Future<void> _onSearchInformasiLayanan(
    SearchInformasiLayananEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(const SearchInitial());
      return;
    }

    if (event.query.trim().length < 2) {
      emit(const SearchError('Kata kunci minimal 2 karakter'));
      return;
    }

    emit(const SearchLoading());

    try {
      final results = await _repository.searchInformasiLayanan(
        event.query,
        page: event.page,
        limit: event.limit,
      );

      if (results.isEmpty) {
        emit(SearchEmpty(event.query));
      } else {
        emit(SearchSuccess(
          results: results,
          currentFilter: SearchFilter.informasiLayanan,
          query: event.query,
        ));
      }
    } catch (e) {
      Logger.log('Search informasi layanan error: $e', tag: 'SearchBloc');
      emit(SearchError('Gagal mencari informasi layanan: ${e.toString()}'));
    }
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchInitial());
  }

  void _onChangeFilter(
    ChangeSearchFilterEvent event,
    Emitter<SearchState> emit,
  ) {
    if (state is SearchSuccess) {
      final currentState = state as SearchSuccess;
      emit(currentState.copyWith(currentFilter: event.filter));
    }
  }
}
