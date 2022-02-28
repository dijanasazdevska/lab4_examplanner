import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/exam.dart';

import 'list_event.dart';
import 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  List<Exam> _elements = [];

  ListBloc() : super(ListInitState()) {
    on<ListInitializedEvent>((event, emit) {
      this._elements = [];
      ListInitState state = ListInitState();
      state.exams = this._elements;
      emit(state);
    });
    on<ListElementAddedEvent>((event, emit) {
      this._elements.add(event.element);
      emit(ListElementsState(exams: this._elements));
    });
    on<ListElementDeletedEvent>((event, emit) {
      this._elements.removeWhere((p) => p.id == event.id);
      if (this._elements.length > 0) {
        emit(ListElementsState(exams: this._elements));
      } else {
        emit(ListEmptyState());
      }
    });
  }
}
