import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:utility/utility.dart';

/// [ManagerService] is the base class for all manager services.
/// including: managing dialog, notification, which requires to
/// display on top of the screen.
abstract interface class ManagerService<R> {
  /// [ManagerService] constructor.
  /// It requires [GlobalKey] to be injected.
  const ManagerService();

  /// [dismiss] is the method to dismiss the widget on top of the screen.
  /// It requires [result] to be injected.
  /// [result] is the result of the widget.
  void dismiss<T>([T? result]);

  /// [show] is the method to show the widget on top of the screen.
  Future<T?> show<T>(
    BuildContext context,
    R type, {
    Widget? title,
    Widget? message,
    Duration duration = const Duration(seconds: 2),
  });

  /// [dispose] is the method to dispose the manager service.
  /// For example, it is used to close the stream controller.
  void dispose();
}


/// [NotificationManagerService] is the base class for all notification manager
/// services, including: managing notification, which requires
/// to display on top of the screen.
abstract interface class NotificationManagerService
    extends ManagerService<NotificationType> {
  /// [NotificationManagerService] constructor.
  const NotificationManagerService();
}

/// [ManagerStateMixin] is the mixin class for all manager states.
/// including: dialog state, notification state, which requires to
/// display on top of the screen.
mixin ManagerStateMixin {
  /// [build] is the method to build the widget on top of the screen.
  Widget build(BuildContext context);
}
