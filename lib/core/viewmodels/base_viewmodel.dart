import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ViewState {
  idle,
  loading,
  success,
  error,
}

extension ViewStateExtension on ViewState {
  bool get isIdle => this == ViewState.idle;
  bool get isLoading => this == ViewState.loading;
  bool get isSuccess => this == ViewState.success;
  bool get isError => this == ViewState.error;
}

class BaseViewModel<T> extends StateNotifier<ViewModelState<T>> {
  BaseViewModel() : super(ViewModelState<T>(state: ViewState.idle));

  // Fetch data and handle different states
  Future<void> fetchData(Future<T> Function() fetchDataFunc) async {
    try {
      state = ViewModelState<T>(state: ViewState.loading);

      final result = await fetchDataFunc();
      state = ViewModelState<T>(state: ViewState.success, data: result);
    } catch (e) {
      state = ViewModelState<T>(state: ViewState.error, error: e.toString());
    }
  }
}

class ViewModelState<T> {
  final ViewState state;
  final T? data;
  final String? error;

  ViewModelState({required this.state, this.data, this.error});
}
