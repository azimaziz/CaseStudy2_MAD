import 'package:casestudy2/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

const List<String> gender = <String>['Male', 'Female'];

class UpdateScreen extends StatefulWidget {
  final DocumentSnapshot patientData;

  const UpdateScreen({Key? key, required this.patientData}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  String dropdownValue = gender.first;
  // ignore: unused_field
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.patientData['Name'];
    _ageController.text = widget.patientData['Age'];
    dropdownValue = widget.patientData['Gender'];
    _dobController.text = widget.patientData['DOB'];
    _occupationController.text = widget.patientData['Occupation'];
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        // Check if a date is selected
        setState(() {
          _selectedDate = value;
          _dobController.text = DateFormat('dd-MM-yyyy').format(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Patient Details",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z '-]")),
                    LengthLimitingTextInputFormatter(24),
                  ],

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
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                  ],

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
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(labelText: 'Gender'),
                  value: dropdownValue,
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
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please choose your gender';
                    }
                    return null;
                  },
                ),
              ),

              //dob
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 230,
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z '-]")),
                    LengthLimitingTextInputFormatter(
                        24), // Limit to 25 characters
                  ],

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
                      Map<String, dynamic> updatedPatientData = {
                        'Name': _nameController.text,
                        'Age': _ageController.text,
                        'Gender': dropdownValue,
                        'DOB': _dobController.text,
                        'Occupation': _occupationController.text,
                      };
                      await DatabaseMethods().updatePatientData(
                          widget.patientData.id, updatedPatientData);

                      // Showing Snack Bar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Updated Successfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Wait for 3 seconds and then navigate back
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    } catch (e) {
                      print('Error updating data: $e');
                    }
                  }
                },
                child: const Text(
                  'Update',
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
