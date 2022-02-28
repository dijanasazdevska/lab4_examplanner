import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab4_examplanner/models/exam.dart';
import 'package:nanoid/nanoid.dart';

class AddExamWidget extends StatefulWidget {
   final Function addItem;

  AddExamWidget(this.addItem);
  @override
  State<StatefulWidget> createState() => _AddExamWidgetState();
}

class _AddExamWidgetState extends State<AddExamWidget> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController(text: "${DateTime.now()}");

  void _submitData() {

    final name = _nameController.text;
    final date = DateTime.parse(_dateController.text);

    if (name.isEmpty) {
      return;
    }

    final newItem = Exam(nanoid(5),name, date);
    widget.addItem(context, newItem);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Enter course name"),
            //  onChanged: (val) {
            //    naslov = val;
            //  }
            onSubmitted: (_) => _submitData(),
          ),
        DateTimeField(onDateSelected: (val){
          setState(() {
            _dateController.text = val.toString();

          });
        }, selectedDate: DateTime.parse(_dateController.text)),
          FlatButton(
            child: Text("Add"),
            onPressed: _submitData,
          ),
        ],
      ),
    );
  }
}
