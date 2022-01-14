import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTodoPage extends StatelessWidget {
  CreateTodoPage({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('Create To-Do',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _titleController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(37, 43, 103, 1)),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Enter title',
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(37, 43, 103, 1))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(37, 43, 103, 1)))),
                  validator: (value) {},
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(37, 43, 103, 1)),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Enter description',
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(37, 43, 103, 1))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(37, 43, 103, 1)))),
                  validator: (value) {},
                ),
                const SizedBox(width: 50),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(const Duration(days: 365)))
                              .then((selectedDate) {
                            final DateFormat _dateFormat =
                                DateFormat('dd/MM/yyyy');
                            _dateController.text =
                                _dateFormat.format(selectedDate!);
                          });
                        },
                        controller: _dateController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: 'Date',
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(37, 43, 103, 1)),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: 'Enter date',
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(37, 43, 103, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(37, 43, 103, 1)))),
                        validator: (value) {},
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((selectedTime) => _timeController.text =
                                  selectedTime!.format(context));
                        },
                        controller: _timeController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                            labelText: 'Time',
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(37, 43, 103, 1)),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: 'Enter time',
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(37, 43, 103, 1))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(37, 43, 103, 1)))),
                        validator: (value) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                
                SizedBox(
                  height: 60,
                  width: 20,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(37, 43, 103, 1)),
                      onPressed: () {},
                      child: const Text('Create',
                          style: TextStyle(color: Colors.white, fontSize: 25))),
                )
              ],
            ),
          ),
        ));
  }
}
