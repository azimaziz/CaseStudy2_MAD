import 'package:casestudy2/pages/create.dart';
import 'package:casestudy2/pages/update.dart';
import 'package:casestudy2/pages/delete.dart';
import 'package:casestudy2/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream? patientStream;

  onLoad() async{
    patientStream = await DatabaseMethods().getPatientData();
    setState(() {
      
    });
  }

  @override
  void initState() {
    onLoad();
    super.initState();
  }

  Widget allPatientDetails(){
    return StreamBuilder(
      stream: patientStream,
      builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData
          ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              DocumentSnapshot ds = snapshot.data.docs[index];
              return Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name: " + ds["Name"],
                              style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              )
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(patientData: ds)));
                                  },
                                  child: Icon(Icons.edit, color:Colors.orange),
                                ),
                                SizedBox(width: 20),  // Space between icons
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteScreen(patientData: ds))); // Replace with your DeleteScreen
                                  },
                                  child: Icon(Icons.delete, color:Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "Age: " + ds["Age"],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                        ),
                        Text(
                          "Occupation: " + ds["Occupation"],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                        )
                      ],
                    )
                  )),
              );
            })
          :Container();
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen()));
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Clinic Patient Details",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              )
            )
          ],
        ),
      ),

      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Expanded(child: allPatientDetails()),
          ]),
      )
    );
  }
}