import 'package:MedBuzz/core/constants/route_names.dart';
import 'package:MedBuzz/core/notifications/fitness_notification_manager.dart';
import 'package:MedBuzz/ui/size_config/config.dart';
import 'package:MedBuzz/ui/views/fitness_reminders/all_fitness_reminders_model.dart';
import 'package:MedBuzz/ui/widget/scrollable_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FitnessSchedulesScreen extends StatefulWidget {
  FitnessSchedulesScreen({this.payload});
  final String payload;
  @override
  _FitnessSchedulesScreenState createState() => _FitnessSchedulesScreenState();
}

class _FitnessSchedulesScreenState extends State<FitnessSchedulesScreen> {
  final ScrollController controller = ScrollController();

  final ItemScrollController itemScrollController = ItemScrollController();

  final FitnessNotificationManager notificationManager =
      FitnessNotificationManager();

  @override
  void initState() {
    notificationManager.initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Some sweet magic to animate FAB
    //This makes the FAB disappear as you scroll down
    controller.addListener(() {
      if (controller.offset < 120) {
        Provider.of<FitnessSchedulesModel>(context).updateVisibility(true);
      } else {
        Provider.of<FitnessSchedulesModel>(context).updateVisibility(false);
      }
    });

    var model = Provider.of<FitnessSchedulesModel>(context);
    //MediaQueries for responsiveness
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: AnimatedOpacity(
        duration: Duration(milliseconds: 800),
        opacity: model.isVisible ? 1 : 0,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 800),
          height: model.isVisible ? Config.yMargin(context, 10) : 0,
          child: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColorLight,
                size: Config.xMargin(context, 9),
              ),
              backgroundColor: Theme.of(context).buttonColor,
              splashColor: Theme.of(context).buttonColor.withOpacity(.9),
              //Navigate to fitness reminder creation screen
              onPressed: () {}),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Fitness',
            style: TextStyle(color: Theme.of(context).primaryColorDark)
            // Theme.of(context)
            //     .textTheme
            //     .headline6
            //     .copyWith(color: Theme.of(context).primaryColorDark),
            ),
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace,
                color: Theme.of(context).primaryColorDark),

            //Function to navigate to previous screen or home screen (as the case maybe) goes here
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.homePage);
            }),
      ),
      body: SingleChildScrollView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: Config.xMargin(context, 3),
                vertical: Config.yMargin(context, 2)),
            child: Column(
              children: <Widget>[
                Container(
                  height: height * .3,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: Config.yMargin(context, 23),
                          child: ScrollableCalendar(
                            model: model,
                            useButtonColor: true,
                            hideDivider: true,
                          )),
                      //Text widget to display current date in MONTH Year format
                      Text(
                        'JUN 2020',
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: Config.textSize(context, 6)),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Config.yMargin(context, 5)),
                //Here the already saved reminders will be loaded dynamically
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '08:00',
                    style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: Config.textSize(context, 6)),
                  ),
                ),
                FitnessCard(),
                FitnessCard(),
                FitnessCard(),
                FitnessCard(),
              ],
            )),
      ),
    );
  }
}

// class CustomDateButton extends StatelessWidget {
//   final DateTime date;

//   CustomDateButton({this.date});
//   @override
//   Widget build(BuildContext context) {
//     var model = Provider.of<FitnessSchedulesModel>(context, listen: false);
//     return Container(
//       margin: EdgeInsets.only(right: Config.xMargin(context, 3)),
//       width: Config.xMargin(context, 19),
//       alignment: Alignment.center,
//       child: FlatButton(
//         onPressed: () => model.changeDay(date),

//         //functionality for finding out if selected date (defaults to present day) equals the date passed in the constructor
//         //I'm using this to determine the color of the container
//         color: model.getButtonColor(context, date),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Config.xMargin(context, 11)),
//         ),
//         child: Container(
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               //Day in integer goes here
//               Text(
//                 '${date.day}',
//                 style: TextStyle(
//                     fontSize: Config.textSize(context, 8),
//                     fontWeight: FontWeight.w600,
//                     color: model.getTextColor(context, date)),
//               ),

//               SizedBox(
//                 height: Config.yMargin(context, 3),
//               ),

//               //Day in shortened words goes here
//               Text(
//                 model.getWeekday(date),
//                 style: TextStyle(
//                     fontSize: Config.textSize(context, 4.8),
//                     fontWeight: FontWeight.w500,
//                     color: model.getTextColor(context, date)),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class FitnessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * .38,
      child: InkWell(
        //Navigate to screen with single reminder i.e the on user clicked on
        onTap: () {
          Navigator.pushNamed(context, RouteNames.singleFitnessScreen);
        },
        splashColor: Theme.of(context).backgroundColor,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                  thickness: 0.7,
                  color: Theme.of(context).primaryColorDark.withOpacity(.4),
                  indent: Config.xMargin(context, 0.5),
                  endIndent: Config.xMargin(context, 2.5)),
              SizedBox(height: Config.yMargin(context, .5)),
              Container(
                width: width,
                height: height * .22,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/sprint.png'),
                      fit: BoxFit.cover),
                  borderRadius:
                      BorderRadius.circular(Config.xMargin(context, 8)),
                ),
              ),
              SizedBox(height: Config.yMargin(context, 2)),
              //Type of fitness exercise goes here
              Text('Running',
                  style: TextStyle(
                      fontSize: Config.textSize(context, 6),
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor)),
              SizedBox(height: Config.yMargin(context, 1)),
              Text('30 minutes daily',
                  style: TextStyle(
                      fontSize: Config.textSize(context, 4.5),
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColorDark)),
            ]),
      ),
    );
  }
}
