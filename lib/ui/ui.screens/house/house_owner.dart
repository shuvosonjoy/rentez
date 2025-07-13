import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.screens/house/house_add_details.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class HouseOwner extends StatefulWidget {
  const HouseOwner({super.key});

  @override
  State<HouseOwner> createState() => _HouseOwnerState();
}

class _HouseOwnerState extends State<HouseOwner> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/House Owner.png',
          fit: BoxFit.cover,
        ),
        toolbarHeight: 100,
        elevation: 15,
        backgroundColor: Colors.grey,
      ),
      body: BackgroundBody(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image upload icon
                  Stack(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: const Color.fromRGBO(22, 82, 131, 1.0),
                          ),
                          child: const Icon(Icons.cloud_upload, color: Colors.white70, size: 50),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Upload a Picture',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Title:',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 10),

                  /// Address input
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        hintText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  /// Phone input
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (addressController.text.isEmpty || phoneController.text.isEmpty) {
                          showToast(message: "All fields are required");
                          return;
                        }

                        try {
                          final houseOwner = HouseOwnerModel(
                            address: addressController.text,
                            phone: int.parse(phoneController.text),
                          );
                          submitHouseOwner(houseOwner);
                        } catch (e) {
                          showToast(message: "Phone must be numeric");
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

                  const SizedBox(height: 50),

                  /// Add Details Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const HouseAddDetails(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 50),
                        elevation: 5,
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black26, width: 2),
                      ),
                      child: const Text(
                        'Add Details',
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

  Future<void> submitHouseOwner(HouseOwnerModel owner) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('House Owner').doc();
      await docRef.set(owner.toMap());
      showToast(message: "Submit Successful");
    } catch (e) {
      showToast(message: "An error occurred while submitting.");
    }
  }
}

class HouseOwnerModel {
  final String address;
  final int phone;

  HouseOwnerModel({
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'phone': phone,
    };
  }
}
