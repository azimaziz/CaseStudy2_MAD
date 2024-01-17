import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:casestudy2/services/database.dart';  // Import your DatabaseMethods class

class DeleteScreen extends StatelessWidget {
  final DocumentSnapshot patientData;

  const DeleteScreen({Key? key, required this.patientData}) : super(key: key);

  Future<void> deletePatient(BuildContext context) async {
    try {
      await DatabaseMethods().deletePatientData(patientData.id);
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Patient deleted successfully')),
      );
      // Go back to the previous screen after deletion
      Navigator.pop(context); // Close the dialog
      Navigator.pop(context); // Go back to the previous screen
    } catch (e) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting patient: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Patient", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              width: double.infinity, // Make the container fill the width of the screen
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Name: ${patientData['Name']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Gender: ${patientData['Gender']}", style: TextStyle(fontSize: 14)),
                      Text("Date of Birth: ${patientData['DOB']}", style: TextStyle(fontSize: 14)),
                      Text("Age: ${patientData['Age']}", style: TextStyle(fontSize: 14)),
                      Text("Occupation: ${patientData['Occupation']}", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Confirm"),
                  content: Text("Are you sure you want to delete this patient?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context), // Close the dialog
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => deletePatient(context),
                      child: Text("Delete"),
                    ),
                  ],
                ),
              ),
              child: Text("Delete Patient", style: TextStyle(fontSize: 18, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
