import 'clock.dart';

final class FakeClock implements Clock {
  FakeClock(DateTime initialNowUtc) : _nowUtc = initialNowUtc.toUtc();

  DateTime _nowUtc;

  @override
  DateTime nowUtc() => _nowUtc;

  void setNow(DateTime value) {
    _nowUtc = value.toUtc();
  }

  void advance(Duration duration) {
    _nowUtc = _nowUtc.add(duration);
  }
}
