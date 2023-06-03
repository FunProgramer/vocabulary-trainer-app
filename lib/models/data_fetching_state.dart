import 'package:vocabulary_trainer_app/exception.dart';

class DataFetchingState<T> {
  LoadingState _state = LoadingState.initial;
  Object? _exception;
  T? _data;

  void loadingState() {
    _state = LoadingState.loading;
  }

  void errorState(Object exception) {
    _exception = exception;
    _state = LoadingState.error;
  }

  void finishedState(T data) {
    _data = data;
    _state = LoadingState.finished;
  }

  LoadingState get state => _state;

  Object get exception {
    if (_state != LoadingState.error) {
      throw NoErrorStateException();
    }
    return _exception!;
  }

  T get data {
    if (_state != LoadingState.finished) {
      throw NoFinishedStateException();
    }
    return _data!;
  }
}

enum LoadingState {
  initial, loading, error, finished
}