import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debouncer {
  final Duration delay;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.delay});

  void call(VoidCallback action) {
    this.action = action;
    _timer?.cancel();
    _timer = Timer(delay, () {
      this.action!();
    });
  }
}
