// ignore_for_file: public_member_api_docs
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DCNotification extends StatelessWidget {
  const DCNotification({
    required this.title,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    this.notificationTime,
    this.haveNotificationTime = false,
    this.heightFactor = 0.12,
    this.widthFactor = 0.9,
    this.titleStyle,
    this.messageStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    super.key,
  })  : assert(
          !haveNotificationTime || notificationTime != null,
          'If haveNotificationTime is true, notificationTime must not be null',
        ),
        assert(
            heightFactor >= 0 &&
                heightFactor <= 1.0 &&
                widthFactor >= 0 &&
                widthFactor <= 1.0,
            'heightFactor must be between 0 and 1.0 and widthFactor must be between 0 and 1.0');

  final Widget title;
  final Widget message;
  final DateTime? notificationTime;
  final bool haveNotificationTime;
  final Color backgroundColor;
  final Color textColor;
  final double heightFactor;
  final double widthFactor;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    var time = '';
    if (haveNotificationTime) {
      time = DateFormat('hh:mm a, d MMM y').format(notificationTime!);
    }

    return FractionallySizedBox(
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return backgroundColor.withOpacity(0.8);
            } else if (states.contains(MaterialState.pressed)) {
              return backgroundColor.withOpacity(0.6);
            } else {
              return backgroundColor;
            }
          }),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            padding,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
          ),
        ),
        onPressed: () => onPressed(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left side
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: DefaultTextStyle.merge(
                style: titleStyle ??
                    context.textTheme.h6BoldPoppins.copyWith(
                      color: textColor,
                      fontSize: 20,
                    ),
                child: title,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: DefaultTextStyle.merge(
                style: messageStyle ??
                    context.textTheme.h6RegularPoppins.copyWith(
                      color: textColor,
                      fontSize: 14,
                    ),
                child: message,
              ),
            ),
            if (haveNotificationTime)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultTextStyle.merge(
                    style: messageStyle ??
                        context.textTheme.h6RegularPoppins.copyWith(
                          color: textColor,
                          fontSize: 14,
                        ),
                    child: Text(time),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}