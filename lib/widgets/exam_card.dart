
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab4_examplanner/models/exam.dart';

class ExamCard extends StatelessWidget{
  final Exam exam;
  ExamCard(this.exam);
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    final String formatted = formatter.format(exam.dateTime);
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      child: ListTile(
        title: Text(exam.courseName),
        subtitle: Text(formatted)
      )
    );
  }

}