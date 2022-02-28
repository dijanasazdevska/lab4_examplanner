import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab4_examplanner/blocs/exams_event.dart';
import 'package:lab4_examplanner/blocs/exams_state.dart';
import 'package:lab4_examplanner/models/user.dart';

class ExamsBloc extends Bloc<ExamsEvent,ExamsState>{
   final List<User> _users = [
     User("dijana.sazdevska","dijana"),
     User("test","test")
   ];
   late User _currentUser;
  ExamsBloc() : super(ExamsNoUserState()){
    on<ExamsUserLoginEvent>((event,emit){
      Iterable<User> users = _users.where((user) => user.username == event.username && user.password == event.password);
      if(users.isEmpty){
        _currentUser = users.first;
        emit(ExamsUserState());
      }
      else{
        emit(ExamsNoUserState());
      }
    });
    on<ExamsElementDeletedEvent>((event,emit){
      _currentUser.exams.removeWhere((exam) => event.id == exam.id);
      if(_currentUser.exams.isEmpty){
        emit(ExamsListEmptyState());
      }
      else{
        emit(ExamsListElementsState(_currentUser.exams));
      }
    });

    on<ExamsElementAddedEvent>((event,emit){
      _currentUser.exams.add(event.exam);
      emit(ExamsListElementsState(_currentUser.exams));
    });

    on<ExamsUserLogoutEvent>((event,emit){
      emit(ExamsNoUserState());
    });



  }

}