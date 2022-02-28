import 'package:lab4_examplanner/models/exam.dart';
import 'package:lab4_examplanner/models/user.dart';

abstract class ExamsEvent {}

class ExamsUserLoginEvent extends ExamsUserListEvent {
  String username;
  String password;
  ExamsUserLoginEvent(this.username,this.password);
}


class ExamsUserLogoutEvent extends ExamsEvent{}

class ExamsUserListEvent extends ExamsEvent{
}

class ExamsElementDeletedEvent extends ExamsEvent{
  final String id;
  ExamsElementDeletedEvent(this.id);
}

class ExamsElementAddedEvent extends ExamsEvent{
  final Exam exam;
  ExamsElementAddedEvent(this.exam);
}

class ExamsListInitializedEvent extends ExamsEvent{

}