
import 'package:geocoder/geocoder.dart';

class Exam{
  String id;
  String courseName;
  DateTime dateTime;
  Coordinates coordinates = Coordinates(0, 0);

  Exam(this.id,this.courseName, this.dateTime);
}