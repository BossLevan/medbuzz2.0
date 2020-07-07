import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/all_scheduled_appointment_reminders.dart';

class PopUpMenu extends StatefulWidget {
  @override
  _PopUpMenuState createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          size: Config.yMargin(context, 3.0),
          color: Colors.grey,
        ),
        itemBuilder: (context) {
          var list = List<PopupMenuEntry<Object>>();
          list.add(
            PopupMenuItem(
              child: GestureDetector(
                child: Center(
                  child: Text(
                    'Edit',
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  ScheduledAppointmentsPage();
                },
              ),
            ),
          );
          list.add(PopupMenuDivider(
            height: Config.yMargin(context, 3.0),
          ));
          list.add(
            PopupMenuItem(
              child: GestureDetector(
                child: Center(
                  child: Text(
                    'Delete',
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  ConfirmAction.Delete;
                },
              ),
            ),
          );
          return list;
        });
  }
}
