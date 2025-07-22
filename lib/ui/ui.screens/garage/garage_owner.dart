import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';
import 'package:rent_ez/ui/ui.screens/garage/garage_add_details.dart';

class GarageOwner extends StatefulWidget {
  const GarageOwner({super.key});

  @override
  State<GarageOwner> createState() => _GarageOwnerState();
}

class _GarageOwnerState extends State<GarageOwner> {
  final TextEditingController phoneController = TextEditingController();
  String? selectedArea;

  final List<String> areaItems = [
    'Subidbazar', 'Zindabazar', 'Ambarkhana', 'Tilaghar', 'Dorga Gate', 'Pathantula',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/Garage Owner.png',
          fit: BoxFit.cover,
        ),
        toolbarHeight: 100,
        elevation: 15,
        backgroundColor: Colors.grey,
      ),
      body: BackgroundBody(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Area:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedArea,
                  items: areaItems.map((area) => DropdownMenuItem(
                    value: area,
                    child: Text(area),
                  )).toList(),
                  onChanged: (value) => setState(() => selectedArea = value),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    elevation: 10,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm() async {
    if (selectedArea == null || phoneController.text.isEmpty) {
      showToast(message: 'All fields are required!');
      return;
    }

    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('Garage Owner')
          .add({
        'address': selectedArea!,
        'phone': phoneController.text,
      });

      showToast(message: 'Submitted Successfully');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GarageAddDetails(ownerId: docRef.id),
        ),
      );

      phoneController.clear();
      setState(() => selectedArea = null);
    } catch (e) {
      showToast(message: 'Error: $e');
    }
  }
}