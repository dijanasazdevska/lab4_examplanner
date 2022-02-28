import 'package:lab4_examplanner/models/exam.dart';

abstract class ExamsState {}

class ExamsNoUserState extends ExamsState{}


class ExamsUserState extends ExamsState {

}

class ExamsListInitState extends ExamsListEmptyState {

}

class ExamsListEmptyState extends ExamsState{

}

class ExamsListElementsState extends ExamsState{
  List<Exam> exams;
  ExamsListElementsState(this.exams);

}