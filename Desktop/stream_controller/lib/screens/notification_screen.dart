import 'dart:async';
import 'package:flutter/material.dart';
import '../components/notification_badge.dart';
import '../components/notification_list.dart';
import '../services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationService _notificationService = NotificationService();
  int _counter = 0;
  Timer? _autoTimer;

  @override
  void initState() {
    super.initState();
    // Simulate automatic notifications every 3 seconds
    _autoTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      _counter++;
      _notificationService.addNotification(_counter);
    });
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _notificationService.dispose();
    super.dispose();
  }

  // Method to manually send a notification event via the stream
  void _sendManualNotification() {
    _counter++;
    _notificationService.addNotification(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones en tiempo real'),
        actions: [
          NotificationBadge(notificationService: _notificationService),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Notificaciones recibidas:',
              style: TextStyle(fontSize: 20),
            ),
            NotificationList(notificationService: _notificationService),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendManualNotification,
              child: Text('Enviar Notificación Manual'),
            ),
          ],
        ),
      ),
    );
  }
}
