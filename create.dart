import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

const List<String> gender = <String>['Male', 'Female'];

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  String dropdownValue = gender.first;
  DateTime? _selectedDate;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _selectedDate = value;
        _dobController.text = _selectedDate.toString().substring(0, 10);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //name
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 18),
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),

                  //validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),

              //age
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 18),
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,

                  //validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
              ),

              //gender
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          style: const TextStyle(fontSize: 18),
                          controller: _genderController,
                          decoration:
                              const InputDecoration(labelText: 'Gender'),

                          //validator
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please choose your gender';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.blue,
                        ),
                        width: 105,
                        height: 35,
                        child: DropdownButton(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.expand_more,
                            color: Colors.white,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          items: gender.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                            _genderController.text = newValue.toString();
                          },
                        ),
                      ),
                    ],
                  )),

              //dob
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            style: const TextStyle(fontSize: 18),
                            controller: _dobController,
                            decoration: const InputDecoration(
                                labelText: 'Date of Birth'),

                            //validatorr
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your date of birth';
                              }
                              return null;
                            },
                          ),
                        ),
                        MaterialButton(
                          onPressed: _showDatePicker,
                          color: Colors.blue,
                          child: const Text(
                            'Select date',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ])),

              //occupation
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 18),
                  controller: _occupationController,
                  decoration: const InputDecoration(labelText: 'Occupation'),

                  //validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your occupation';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 20),

              //submit button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      String uid = randomAlphaNumeric(10);
                      /*Map<String, dynamic> patientData = {
                        'Name': _nameController.text,
                        'Age': _ageController.text,
                        'Gender': _genderController.text,
                        'DOB': _dobController.text,
                        'Cccupation': _occupationController.text,
                      };*/
                      final collection = FirebaseFirestore.instance
                          .collection('Register'); //collection name

                      await collection.doc().set({
                        'UID': uid,
                        'Name': _nameController.text,
                        'Age': _ageController.text,
                        'Gender': _genderController.text,
                        'DOB': _dobController.text,
                        'Cccupation': _occupationController.text,
                      });
                    } catch (_) {
                      print('Error');
                    }
                    print('Form data submitted!');
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

