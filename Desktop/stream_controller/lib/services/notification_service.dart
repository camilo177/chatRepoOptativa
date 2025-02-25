import 'dart:async';

class NotificationService {
  final StreamController<int> _notificationController =
      StreamController<int>.broadcast();

  Stream<int> get notificationStream => _notificationController.stream;

  void addNotification(int count) {
    _notificationController.add(count);
  }

  void dispose() {
    _notificationController.close();
  }
}
