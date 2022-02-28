import 'package:lab4_examplanner/models/exam.dart';

abstract class PlannerState {}

class PlannerNoUserState extends PlannerState{}

class PlannerListEmptyState extends PlannerState{}

class PlannerHasUserState extends PlannerState{}

class PlannerListElementsState extends PlannerState{
  List<Exam> exams;

  PlannerListElementsState(this.exams);
}


