import 'dart:async';

import 'package:notification_center/models/notification.dart'
    show NotificationModel;

/// NotificationCenterBloc - logic of notification show/hide, hold history.
class NotificationCenterBloc {
  /// history - all notifications that have been shown.
  final List<NotificationModel> history;

  /// notifications - for add notification to history.
  StreamController<NotificationModel>? notifications;

  StreamController<List<NotificationModel>>? _notificationsController;

  StreamController<int>? _notificationsCountController;

  /// notificationsCount - count of notifications.
  Stream<int>? notificationsCount;

  /// notificationsForShow - notifications for show only.
  Stream<List<NotificationModel>>? notificationsForShow;

  /// Constructor
  NotificationCenterBloc() : history = [] {
    _notificationsController = StreamController<List<NotificationModel>>();
    notificationsForShow = _notificationsController!.stream.asBroadcastStream();

    notifications = StreamController<NotificationModel>();
    notifications?.stream.listen((notification) {
      history.add(notification);
      _notificationsCountController?.add(history.length);
      if (notification.showWithNotificationsFromHistory) {
        _notificationsController?.add(history);
      } else {
        _notificationsController?.add([notification]);
      }
    });

    _notificationsCountController = StreamController<int>();
    notificationsCount = _notificationsCountController?.stream;
  }

  /// dispose - must be call when widget of bloc is disposed.
  void dispose() {
    notifications?.close();
    _notificationsController?.close();
    _notificationsCountController?.close();
  }

  /// getAllNotifications - call for get all notifications from history.
  /// Need for some controls of notification center.
  void showAllNotifications() => _notificationsController?.add(history);

  /// closeAllNotifications - call for get empty list of notifications.
  /// Need for some controls of notification center.
  void closeAllNotifications() => _notificationsController?.add([]);
}
