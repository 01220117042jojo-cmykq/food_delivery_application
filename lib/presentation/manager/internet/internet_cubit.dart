import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum InternetState { initial, connected, disconnected }

class InternetCubit extends Cubit<InternetState> {
  StreamSubscription? _subscription;
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.instance;

  InternetCubit() : super(InternetState.initial) {
    _monitorConnection();
  }

  void _monitorConnection() {
    _checkInitialConnection();

    _subscription = _connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        emit(InternetState.connected);
      } else {
        emit(InternetState.disconnected);
      }
    });
  }

  Future<void> _checkInitialConnection() async {
    bool hasConnection = await _connectionChecker.hasConnection;
    if (hasConnection) {
      emit(InternetState.connected);
    } else {
      emit(InternetState.disconnected);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
