import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/data_fetching_state.dart';

class DataFetcher<T> extends StatefulWidget {
  final Future<T> Function() loadData;
  final Widget loadingWidget;
  final Widget Function(Object exception) onError;
  final Widget Function(T data) onFinished;

  const DataFetcher(
      {super.key,
      required this.loadData,
      required this.loadingWidget,
      required this.onError,
      required this.onFinished});

  @override
  State<DataFetcher> createState() => _DataFetcherState<T>();
}

class _DataFetcherState<T> extends State<DataFetcher> {
  final DataFetchingState _state = DataFetchingState<T>();
  
  @override
  void initState() {
    super.initState();
    _fetchData();
  }
  
  Future<void> _fetchData() async {
    setState(() => _state.loadingState());
    try {
      T data = await widget.loadData();
      setState(() {
        _state.finishedState(data);
      });
    } catch(e) {
      setState(() => _state.errorState(e));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Widget resultWidget;

    switch(_state.state) {
      case LoadingState.initial:
        resultWidget = Text(S.of(context).loadingNotStarted);
        break;
      case LoadingState.loading:
        resultWidget = widget.loadingWidget;
        break;
      case LoadingState.error:
        resultWidget = widget.onError(_state.exception);
        break;
      case LoadingState.finished:
        resultWidget = widget.onFinished(_state.data);
        break;
    }

    return resultWidget;
  }
}
