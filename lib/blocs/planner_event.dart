import 'package:lab4_examplanner/models/exam.dart';

abstract class PlannerEvent {}

class PlannerInitializedEvent extends PlannerEvent{

}

class PlannerUserLogoutEvent extends PlannerEvent{

}

class PlannerUserLoginEvent extends PlannerEvent{
  final String username;
  final String password;

  PlannerUserLoginEvent(this.username, this.password);

}

class PlannerListInitializedEvent extends PlannerEvent{

}

class PlannerListAddExamEvent extends PlannerEvent{
  final Exam exam;
  PlannerListAddExamEvent(this.exam);
}

class PlannerListDeleteExamEvent extends PlannerEvent{
  final String id;
  PlannerListDeleteExamEvent(this.id);
}

class PlannerCalendarDateChangedEvent extends PlannerEvent{
  final DateTime date;
  PlannerCalendarDateChangedEvent(this.date);
}
