import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class BookBand extends StatefulWidget {
  BookBand({Key? key}) : super(key: key);

  @override
  _BookBandState createState() => _BookBandState();
}

class _BookBandState extends State<BookBand> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  final dbRef = FirebaseDatabase.instance.reference();

  late DateTime dateTime;

  void writeData() async {
    _formKey.currentState!.save();
    var url =
        "https://musicbandapp-default-rtdb.asia-southeast1.firebasedatabase.app/" +
            "data.json";

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "name": nameController.text,
            "address": addressController.text,
            "cost": costController.text,
            "date": dateController.text,
            "contact": contactController.text
          }));
      Fluttertoast.showToast(
          msg: "Data added successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3);
    } catch (e) {
      print("Error = " + e.toString());
    }
  }
  
  @override
  void initState() { 
    super.initState();
    dateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          body: Padding(
              padding: EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text(
                        "Book Band",
                        style: TextStyle(
                            backgroundColor: Color(0xFF3b9c9a),
                            fontSize: 45.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Name is required" : null,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: "Address",
                          contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Address is required" : null,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        controller: costController,
                        decoration: InputDecoration(
                          labelText: "Cost",
                          contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Cost is required" : null,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        controller: dateController,
                        onTap: _pickDate,
                        decoration: InputDecoration(
                          labelText: "Date",
                          contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        // validator: (value) =>
                        //     value!.isEmpty ? "Date is required" : null,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: TextFormField(
                        controller: contactController,
                        decoration: InputDecoration(
                          labelText: "Contact",
                          contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Contact is required" : null,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: ElevatedButton(
                          onPressed: () async {
                            writeData();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            primary: Color(0xFF3b9c9a),
                          ),
                          child: Text(
                            "BOOK",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          )),
                    )
                  ],
                ),
              )),
        ));
  }

  Future _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context, 
      initialDate: dateTime, 
      firstDate: DateTime(DateTime.now().year), 
      lastDate: DateTime(DateTime.now().year)
      );

      if(date == null)
       setState(() {
        //  data.registrationdate = date.toString(),
       dateController.text = date.toString();
       }
       );
  }

}
