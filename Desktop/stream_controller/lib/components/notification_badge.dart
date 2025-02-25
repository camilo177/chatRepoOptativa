import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationBadge extends StatelessWidget {
  final NotificationService notificationService;

  const NotificationBadge({
    Key? key,
    required this.notificationService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: notificationService.notificationStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 16.0),
            child: Badge(
              label: Text('${snapshot.data}'),
              child: Icon(Icons.notifications),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.notifications),
          );
        }
      },
    );
  }
}
