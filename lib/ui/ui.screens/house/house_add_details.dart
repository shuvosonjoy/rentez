import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class HouseAddDetails extends StatefulWidget {
  final String ownerId;

  const HouseAddDetails({super.key, required this.ownerId});

  @override
  State<HouseAddDetails> createState() => _HouseAddDetailsState();
}

class _HouseAddDetailsState extends State<HouseAddDetails> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController houseRentController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController roadNoController = TextEditingController();
  final TextEditingController areaDetailsController = TextEditingController();
  bool isSubmitting = false;

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
                  const Center(
                    child: Text(
                      'Provide House Information',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 30),

                  _buildInputField('Description', descriptionController, maxLines: 2),
                  const SizedBox(height: 20),
                  _buildInputField('House Rent', houseRentController, keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  _buildInputField('House no.', houseNoController),
                  const SizedBox(height: 20),
                  _buildInputField('Road No.', roadNoController, keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  _buildInputField('Area Details (e.g., Block, Sector)', areaDetailsController),

                  const SizedBox(height: 40),
                  Center(
                    child: isSubmitting
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: submitDetails,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        fixedSize: const Size(200, 60),
                        elevation: 10,
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Submit Details',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _buildInputField(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Future<void> submitDetails() async {
    if (descriptionController.text.isEmpty ||
        houseRentController.text.isEmpty ||
        houseNoController.text.isEmpty ||
        roadNoController.text.isEmpty ||
        areaDetailsController.text.isEmpty) {
      showToast(message: "Please fill all fields");
      return;
    }

    setState(() => isSubmitting = true);

    try {
      // Parse numerical values
      final houseRent = int.tryParse(houseRentController.text);
      final roadNo = int.tryParse(roadNoController.text);

      if (houseRent == null || roadNo == null) {
        showToast(message: "Invalid number format");
        return;
      }

      final details = {
        'ownerId': widget.ownerId,
        'description': descriptionController.text,
        'houseRent': houseRent,
        'houseNo': houseNoController.text,
        'roadNo': roadNo,
        'areaDetails': areaDetailsController.text,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Save to Firestore
      await FirebaseFirestore.instance.collection('House Details').add(details);
      showToast(message: "Details Submitted Successfully");
      Navigator.pop(context);  // Return to previous screen
    } catch (e) {
      showToast(message: "Error: $e");
    } finally {
      setState(() => isSubmitting = false);
    }
  }
}