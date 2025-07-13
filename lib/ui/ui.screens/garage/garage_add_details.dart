import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class GarageAddDetails extends StatefulWidget {
  const GarageAddDetails({super.key});

  @override
  State<GarageAddDetails> createState() => _GarageAddDetailsState();
}

class _GarageAddDetailsState extends State<GarageAddDetails> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController garageRentController = TextEditingController();
  final TextEditingController garageNoController = TextEditingController();
  final TextEditingController roadNoController = TextEditingController();
  final TextEditingController areaDetailsController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    garageRentController.dispose();
    garageNoController.dispose();
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
                      'Provide Garage Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(descriptionController, 'Description'),
                  const SizedBox(height: 20),
                  _buildTextField(garageRentController, 'Garage Rent', isNumber: true),
                  const SizedBox(height: 20),
                  _buildTextField(garageNoController, 'Garage no.'),
                  const SizedBox(height: 20),
                  _buildTextField(roadNoController, 'Road No.', isNumber: true),
                  const SizedBox(height: 20),
                  _buildTextField(areaDetailsController, 'Area Details'),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submit,
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

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }

  void _submit() {
    // Basic validation
    if (descriptionController.text.isEmpty ||
        garageRentController.text.isEmpty ||
        garageNoController.text.isEmpty ||
        roadNoController.text.isEmpty ||
        areaDetailsController.text.isEmpty) {
      showToast(message: "Please fill all fields");
      return;
    }

    final garageRent = int.tryParse(garageRentController.text);
    final roadNo = int.tryParse(roadNoController.text);

    if (garageRent == null || roadNo == null) {
      showToast(message: "Please enter valid numbers for rent and road no.");
      return;
    }

    final user = User(
      description: descriptionController.text,
      garageRent: garageRent,
      garageNo: garageNoController.text,
      roadNo: roadNo,
      areaDetails: areaDetailsController.text,
    );

    garageAddDetails(user);
  }

  Future<void> garageAddDetails(User user) async {
    try {
      final docUser =
      FirebaseFirestore.instance.collection('Garage Add Details').doc();
      await docUser.set(user.toGarage());
      showToast(message: "Submit Successful");
    } catch (e) {
      showToast(message: 'Some error occurred');
    }
  }
}

class User {
  final String description;
  final int garageRent;
  final String garageNo;
  final int roadNo;
  final String areaDetails;

  User({
    required this.description,
    required this.garageRent,
    required this.garageNo,
    required this.roadNo,
    required this.areaDetails,
  });

  Map<String, dynamic> toGarage() => {
    'description': description,
    'garageRent': garageRent,
    'garageNo': garageNo,
    'roadNo': roadNo,
    'areaDetails': areaDetails,
  };
}
