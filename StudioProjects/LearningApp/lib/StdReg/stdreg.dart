import 'package:flutter/material.dart';

class StudentProfileRegistrationPage extends StatefulWidget {
  const StudentProfileRegistrationPage({super.key});

  @override
  _StudentProfileRegistrationPageState createState() =>
      _StudentProfileRegistrationPageState();
}

class _StudentProfileRegistrationPageState
    extends State<StudentProfileRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _studentNameController = TextEditingController();
  TextEditingController _gradeController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _studentNameController,
                decoration: InputDecoration(labelText: 'Student Name'),
                validator: (value) {
                  if (value==null||value.isNotEmpty) {
                    return 'Please enter the student name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gradeController,
                decoration: InputDecoration(labelText: 'Grade'),
                validator: (value) {
                  if (value==null||value.isNotEmpty) {
                    return 'Please enter the grade';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value==null||value.isNotEmpty) {
                    return 'Please enter the age';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _registerStudentProfile();
                },
                child: Text('Register Student Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerStudentProfile() {
    if (_formKey.currentState!.validate()) {
      String studentName = _studentNameController.text;
      String grade = _gradeController.text;
      int age = int.parse(_ageController.text);

      Navigator.pop(context);
    }
  }
}
