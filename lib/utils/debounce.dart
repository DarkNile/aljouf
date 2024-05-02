import 'dart:async';
import 'dart:ui';

class Debounce {
  final Duration delay;
  VoidCallback? action;
  Timer? _timer;

  Debounce(this.delay);

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
