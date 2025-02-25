import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationList extends StatelessWidget {
  final NotificationService notificationService;

  const NotificationList({
    Key? key,
    required this.notificationService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: notificationService.notificationStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            'Total de notificaciones: ${snapshot.data}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
