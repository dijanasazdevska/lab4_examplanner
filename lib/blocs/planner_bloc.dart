import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4_examplanner/models/exam.dart';
import '../blocs/planner_event.dart';
import '../blocs/planner_state.dart';
import '../models/user.dart';

class PlannerBloc extends Bloc<PlannerEvent,PlannerState>{
  List<User> _users = [];
  late User _currentUser;
  late DateTime currentDate;
  List<Exam> exams = [];
  PlannerBloc() : super(PlannerNoUserState()){
    on<PlannerInitializedEvent>((event,emit){
      _users = [
        User("dijana.sazdevska","test123!"),
        User("test1","test1")

      ];
      emit(PlannerNoUserState());
    });

    on<PlannerUserLogoutEvent>((event,emit){
      emit(PlannerNoUserState());
    });

    on<PlannerUserLoginEvent>((event,emit){
      final users = _users.where((user) => user.username == event.username && user.password == user.password);
      if(users.isNotEmpty){
        _currentUser = users.first;
        currentDate = DateTime.now();
        exams = _getExamsPerDay(currentDate);
        exams.isNotEmpty?emit(PlannerListElementsState(exams)):PlannerListEmptyState();

      }
      else{
        emit(PlannerNoUserState());
      }
    });

    on<PlannerListInitializedEvent>((event,emit){
      currentDate = DateTime.now();
      exams = _getExamsPerDay(currentDate);
      exams.isNotEmpty?emit(PlannerListElementsState(exams)):PlannerListEmptyState();


    });

    on<PlannerCalendarDateChangedEvent>((event,emit){
      currentDate = event.date;
      exams = _getExamsPerDay(currentDate);
      exams.isNotEmpty?emit(PlannerListElementsState(exams)):emit(PlannerListEmptyState());
    });

    on<PlannerListAddExamEvent>((event,emit){
      _currentUser.exams.add(event.exam);
      emit(PlannerListElementsState(exams));
    });
  }

  List<Exam> _getExamsPerDay(DateTime date){
    return _currentUser.exams.where((exam) => exam.dateTime.day == date.day && exam.dateTime.month == date.month  && date.year == exam.dateTime.year).toList();

  }
   loadEvents(DateTime date){
    return _getExamsPerDay(date).map((exam) => exam.courseName);
  }

}