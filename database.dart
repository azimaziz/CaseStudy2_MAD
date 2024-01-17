import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  Future register(Map<String,dynamic> patientData,String id) async {
    return await FirebaseFirestore.instance
            .collection('Register')
            .doc(id)
            .set(patientData);
  }

  Future<Stream<QuerySnapshot>> getPatientData() async {
    return await FirebaseFirestore.instance
            .collection('Register')
            .snapshots();
  }

  Future updatePatientData(String id, Map<String, dynamic> patientData) async {
    return await FirebaseFirestore.instance
            .collection('Register')
            .doc(id)
            .update(patientData);
  }

  Future deletePatientData(String id) async {
    return await FirebaseFirestore.instance
        .collection('Register')
        .doc(id)
        .delete();
  }
}