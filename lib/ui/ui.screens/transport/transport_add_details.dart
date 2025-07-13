import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class TransportAddDetails extends StatefulWidget {
  const TransportAddDetails({super.key});

  @override
  State<TransportAddDetails> createState() => _TransportAddDetailsState();
}

class _TransportAddDetailsState extends State<TransportAddDetails> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController transportRentController = TextEditingController();
  final TextEditingController transportNoController = TextEditingController();
  final TextEditingController areaDetailsController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    transportRentController.dispose();
    transportNoController.dispose();
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
                      'Provide Transport Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(hintText: 'Description'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: transportRentController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Transport Rent'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: transportNoController,
                      decoration: const InputDecoration(hintText: 'Transport no.'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: areaDetailsController,
                      decoration: const InputDecoration(hintText: 'Area Details'),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Simple input validation
                        if (descriptionController.text.isEmpty ||
                            transportRentController.text.isEmpty ||
                            transportNoController.text.isEmpty ||
                            areaDetailsController.text.isEmpty) {
                          showToast(message: "Please fill all fields");
                          return;
                        }

                        final rent = int.tryParse(transportRentController.text);
                        if (rent == null) {
                          showToast(message: "Please enter a valid number for rent");
                          return;
                        }

                        final user = User(
                          description: descriptionController.text.trim(),
                          transportRent: rent,
                          transportNo: transportNoController.text.trim(),
                          areaDetails: areaDetailsController.text.trim(),
                        );

                        transportAddDetails(user);
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 50),
                        elevation: 5,
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black26, width: 2),
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

  Future<void> transportAddDetails(User user) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('Transport Add Details').doc();

      await docUser.set(user.toTransport());

      showToast(message: "Submit Successful");
    } catch (e) {
      showToast(message: 'Some error occurred');
      debugPrint('Error saving transport add details: $e');
    }
  }
}

class User {
  final String description;
  final String transportNo;
  final int transportRent;
  final String areaDetails;

  User({
    required this.description,
    required this.transportRent,
    required this.transportNo,
    required this.areaDetails,
  });

  Map<String, dynamic> toTransport() => {
    'description': description,
    'transportRent': transportRent,   // Fixed: changed key from 'garageRent' to 'transportRent'
    'transportNo': transportNo,       // Fixed: changed key from 'garageNo' to 'transportNo'
    'areaDetails': areaDetails,
  };
}
