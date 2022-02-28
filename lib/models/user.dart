import 'exam.dart';

class User {
  String username;
  String password;
  List<Exam> exams;
  User(this.username, this.password, {this.exams = const<Exam>[]});

}