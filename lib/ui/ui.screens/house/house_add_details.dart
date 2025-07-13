import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class HouseAddDetails extends StatefulWidget {
  const HouseAddDetails({super.key});

  @override
  State<HouseAddDetails> createState() => _HouseAddDetailsState();
}

class _HouseAddDetailsState extends State<HouseAddDetails> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController houseRentController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController roadNoController = TextEditingController();
  final TextEditingController areaDetailsController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    houseRentController.dispose();
    houseNoController.dispose();
    roadNoController.dispose();
    areaDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/Add Details.png',
          fit: BoxFit.cover,
        ),
        toolbarHeight: 100,
        elevation: 15,
        backgroundColor: Colors.grey,
      ),
      body: BackgroundBody(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Provide House Information',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: houseRentController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'House Rent',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: houseNoController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'House no.',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: roadNoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Road No.',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: areaDetailsController,
                      decoration: InputDecoration(
                        hintText: 'Area Details',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (descriptionController.text.isEmpty ||
                            houseRentController.text.isEmpty ||
                            houseNoController.text.isEmpty ||
                            roadNoController.text.isEmpty ||
                            areaDetailsController.text.isEmpty) {
                          showToast(message: "Please fill all fields");
                          return;
                        }

                        try {
                          final details = HouseDetailsModel(
                            description: descriptionController.text,
                            houseRent: int.parse(houseRentController.text),
                            houseNo: houseNoController.text,
                            roadNo: int.parse(roadNoController.text),
                            areaDetails: areaDetailsController.text,
                          );

                          houseAddDetails(details);
                        } catch (e) {
                          showToast(message: "Please enter valid numbers for Rent and Road No.");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 50),
                        elevation: 5,
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.green, width: 2),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> houseAddDetails(HouseDetailsModel details) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('House Add Details').doc();
      await docUser.set(details.toMap());
      showToast(message: "Submit Successful");
    } catch (e) {
      showToast(message: 'Some error occurred');
    }
  }
}

class HouseDetailsModel {
  final String description;
  final int houseRent;
  final String houseNo;
  final int roadNo;
  final String areaDetails;

  HouseDetailsModel({
    required this.description,
    required this.houseRent,
    required this.houseNo,
    required this.roadNo,
    required this.areaDetails,
  });

  Map<String, dynamic> toMap() => {
    'description': description,
    'houseRent': houseRent,
    'houseNo': houseNo,
    'roadNo': roadNo,
    'areaDetails': areaDetails,
  };
}
