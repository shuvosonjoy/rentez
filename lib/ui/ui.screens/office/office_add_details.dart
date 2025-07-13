import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class OfficeAddDetails extends StatefulWidget {
  const OfficeAddDetails({super.key});

  @override
  State<OfficeAddDetails> createState() => _OfficeAddDetailsState();
}

class _OfficeAddDetailsState extends State<OfficeAddDetails> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController officeRentController = TextEditingController();
  final TextEditingController roadNoController = TextEditingController();
  final TextEditingController areaDetailsController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    officeRentController.dispose();
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
                      'Provide Office Information',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(descriptionController, 'Description'),
                  const SizedBox(height: 20),
                  _buildTextField(officeRentController, 'Office Rent',
                      inputType: TextInputType.number),
                  const SizedBox(height: 20),
                  _buildTextField(roadNoController, 'Road No.',
                      inputType: TextInputType.number),
                  const SizedBox(height: 20),
                  _buildTextField(areaDetailsController, 'Area Details'),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateInputs()) {
                          final user = OfficeDetailsUser(
                            description: descriptionController.text.trim(),
                            officeRent:
                            int.parse(officeRentController.text.trim()),
                            roadNo: int.parse(roadNoController.text.trim()),
                            areaDetails: areaDetailsController.text.trim(),
                          );

                          _officeAddDetails(user);
                        }
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

  Widget _buildTextField(TextEditingController controller, String hintText,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (descriptionController.text.isEmpty ||
        officeRentController.text.isEmpty ||
        roadNoController.text.isEmpty ||
        areaDetailsController.text.isEmpty) {
      showToast(message: 'Please fill in all fields');
      return false;
    }

    if (int.tryParse(officeRentController.text) == null ||
        int.tryParse(roadNoController.text) == null) {
      showToast(message: 'Rent and Road No. must be numbers');
      return false;
    }

    return true;
  }

  Future<void> _officeAddDetails(OfficeDetailsUser user) async {
    try {
      final doc = FirebaseFirestore.instance.collection('Office Add Details').doc();
      await doc.set(user.toMap());
      showToast(message: 'Submit Successful');
    } catch (e) {
      showToast(message: 'Some error occurred');
    }
  }
}

class OfficeDetailsUser {
  final String description;
  final int officeRent;
  final int roadNo;
  final String areaDetails;

  OfficeDetailsUser({
    required this.description,
    required this.officeRent,
    required this.roadNo,
    required this.areaDetails,
  });

  Map<String, dynamic> toMap() => {
    'description': description,
    'officeRent': officeRent,
    'roadNo': roadNo,
    'areaDetails': areaDetails,
  };
}
