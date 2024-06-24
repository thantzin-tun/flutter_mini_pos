import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  bool isConnected = false;

  Future<bool> checkConnectivity() async {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _connectionStatus = result.first;
      isConnected = _connectionStatus != ConnectivityResult.none;
    });
    return isConnected;
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}
