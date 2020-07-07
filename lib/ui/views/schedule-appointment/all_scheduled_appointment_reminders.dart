import 'package:MedBuzz/core/models/appointment_reminder.dart';
import 'package:MedBuzz/ui/views/schedule-appointment/all_scheduled_appointment_reminders_model.dart';
import 'package:flutter/material.dart';
import 'package:MedBuzz/ui/app_theme/app_theme.dart';
import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/ui/widget/appointment_card.dart';
import 'package:MedBuzz/core/database/appointmentData.dart';
import 'package:provider/provider.dart';

class ScheduledAppointmentsPage extends StatefulWidget {
  @override
  _ScheduledAppointmentsPageState createState() {
    return _ScheduledAppointmentsPageState();
  }
}

class _ScheduledAppointmentsPageState extends State<ScheduledAppointmentsPage> {
  dynamic activeAppointments = AppointmentData().getActiveAppointment();
  void Appointments = AppointmentData().getAppointments();
  @override
  Widget build(BuildContext context) {
    // var model = Provider.of<AppointmentModel>(context);
    return DefaultTabController(
      length: 2,
      child: new Scaffold(
        backgroundColor: appThemeLight.backgroundColor,
        appBar: AppBar(
          backgroundColor: appThemeLight.appBarTheme.color,
          title: Container(
            child: Container(
              child: new Text(
                'My Appointments',
                style: appThemeLight.textTheme.headline5,
                textScaleFactor: 1.5,
              ),
            ),
          ),
          leading: Container(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: appThemeLight.appBarTheme.iconTheme.color,
              ),

              // navigate to add appointments page

              onPressed: () => {
                Navigator.pushReplacementNamed(context, RouteNames.homePage)
              },
            ),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: appThemeLight.primaryColor,
            labelColor: appThemeLight.primaryColorDark.withOpacity(0.9),
            unselectedLabelColor:
                appThemeLight.primaryColorDark.withOpacity(0.9),
            indicatorWeight: 2.0,
            tabs: [
              Tab(
                child: Text(
                  'Upcoming',
                  style: appThemeLight.textTheme.headline6,
                ),
              ),
              Tab(
                child: Text(
                  'Past',
                  style: appThemeLight.textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushReplacementNamed(context, RouteNames.homePage);
            return Future.value(false);
          },
          child: TabBarView(
            children: [
              ListView.builder(
                // Let the ListView know how many items it needs to build.
                itemCount: AppointmentData().appointmentCount,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final activeAppointment = activeAppointments[index];
                  return AppointmentCard();
                },
              ),
              ListView.builder(
                // Let the ListView know how many items it needs to build.
                itemCount: AppointmentData().appointmentCount,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  // final inactiveAppointment ;
                  return AppointmentCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
