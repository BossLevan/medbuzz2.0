import 'package:MedBuzz/core/database/appointmentData.dart';

DateTime selectedTime = AppointmentData().appointmentTime;
DateTime now = DateTime.now();

DateTime open = DateTime(
    now.year, now.month, now.day, selectedTime.year, open.hour, open.minute);

// enum _reminderState {Completed, Skipped, Upcoming}

//// Future action to return reminder state
//for each ListItem {
//  if (DateAndDay > Date.time(now)) {
//    print('Reminder is Completed.');
//    else{
//      print('Reminder was Skipped');
//}
//  } else {
//    print('Reminder is Upcoming');
//}
//
//}
