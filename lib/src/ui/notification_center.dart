import 'package:flutter/material.dart';

class NotificationCenter extends StatefulWidget {
  Widget child;

  NotificationCenter({this.child});

  @override
  _NotificationCenterState createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
