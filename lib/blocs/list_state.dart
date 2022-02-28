
import '../models/exam.dart';

abstract class ListState {}

class ListInitState extends ListElementsState {
  ListInitState() : super(exams: []);
}

class ListEmptyState extends ListState {}

class ListElementsState extends ListState {
  List<Exam> exams;
  ListElementsState({required this.exams});
}

class ListError extends ListState {
  final error;
  ListError({this.error});
}
