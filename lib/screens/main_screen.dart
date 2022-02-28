
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lab4_examplanner/blocs/planner_bloc.dart';
import 'package:lab4_examplanner/blocs/planner_event.dart';
import 'package:lab4_examplanner/blocs/planner_state.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/add_exam_widget.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';

class MainScreen extends StatelessWidget {
   MainScreen({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  late FlutterLocalNotificationsPlugin fltrNotification;


  @override
  Widget build(BuildContext context) {
    var androidInitilize = AndroidInitializationSettings('app_icon');
    var iOSinitilize = IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);

    return Scaffold(
        appBar: _createAppBar(context),
        body: _createBody(context)
    );
  }

  Future notificationSelected(String? payload) async {
  }

  void _addItemFunction(BuildContext ct) {
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddExamWidget(_addNewItemToList),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Future _addNewItemToList(BuildContext ctx, Exam exam) async {
//add
  final bloc = BlocProvider.of<PlannerBloc>(ctx);
  bloc.add(PlannerListAddExamEvent(exam));

  var androidDetails = AndroidNotificationDetails(
        "Channel ID", "",
        importance: Importance.max);

    var iSODetails = new IOSNotificationDetails();

    var generalNotificationDetails = new NotificationDetails(
        android: androidDetails, iOS: iSODetails);

    await fltrNotification.schedule(
        0, "Exam Planner", "${exam.courseName} is started.", exam.dateTime,
        generalNotificationDetails);
  }

   _createAppBar(BuildContext context){
    return AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
        title: Text(title),
        actions: [
          IconButton(
              icon: Icon(Icons.playlist_add),
              onPressed: () => _addItemFunction(context)
          )
        ]
    );
  }

  Widget _createBody(BuildContext context) {
      return BlocBuilder<PlannerBloc, PlannerState>(builder: (context, state){
        if(state is PlannerNoUserState ) {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed("/login");
          });
        }
        return Column(children: [
          TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              eventLoader: (day) => _getEventByDay(context,day)),
          context.runtimeType == PlannerListEmptyState ?
          Center(child: Text("No exams provided for this date")): Expanded(
              child:
              Container(
                  child: ListView.builder(
                      itemCount: (state as PlannerListElementsState).exams.length,
                      itemBuilder: (context, index) {
                        return ExamCard((state as PlannerListElementsState).exams[index]);
                      }
                  )))
        ]);
      });
      }
}

_getEventByDay(ctx, day) {
  final bloc = BlocProvider.of<PlannerBloc>(ctx);
  return  bloc.loadEvents(day);
}
