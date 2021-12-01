import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mocci/app/data/constants.dart';
import 'package:mocci/app/modules/settings/controllers/settings_controller.dart';

class NotificationView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: kTextStyle.f18w6.copyWith(color: kColors.DARK_BLUE),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(kDynamicWidth.width20),
        children: [
          CustomNotificationField(
              'Email Notifications', (value) => print("Value updated: $value")),
        ],
      ),
    );
  }
}

class CustomNotificationField extends StatelessWidget {
  CustomNotificationField(this._title, this.onchange);

  final String _title;
  final Function onchange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _title,
          style:
              kTextStyle.f18w6.copyWith(fontSize: 16, color: kColors.DARK_BLUE),
        ),
        ValueBuilder<bool>(
          initialValue: false,
          builder: (value, update) => Switch(
            activeColor: kColors.ERROR_YELLOW,
            activeTrackColor: kColors.ERROR_YELLOW.withOpacity(0.6),
            value: value,
            onChanged: (flag) {
              update(flag);
            },
          ),
          onUpdate: onchange,
        ),
      ],
    );
  }
}
