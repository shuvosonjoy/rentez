import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.screens/transport/transport_add_details.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class TransportOwner extends StatefulWidget {
  const TransportOwner({super.key});

  @override
  State<TransportOwner> createState() => _TransportOwnerState();
}

class _TransportOwnerState extends State<TransportOwner> {
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
          'assets/images/Transport Owner.png',
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
                  Stack(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 80,
                        // Empty SizedBox with ClipRRect does nothing visually,
                        // consider adding an image or removing if unused
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
                            color: Colors.indigo,
                          ),
                          child: const Icon(
                            Icons.cloud_upload,
                            color: Colors.white70,
                            size: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Upload a Picture',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Title :',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        hintText: 'Address',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Phone',
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (addressController.text.isEmpty || phoneController.text.isEmpty) {
                          showToast(message: "Please fill all fields");
                          return;
                        }
                        final phoneNumber = int.tryParse(phoneController.text);
                        if (phoneNumber == null) {
                          showToast(message: "Enter a valid phone number");
                          return;
                        }

                        final user = User(
                          address: addressController.text.trim(),
                          phone: phoneNumber,
                        );
                        transportOwner(user);
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
                  const SizedBox(height: 50),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TransportAddDetails(),
                          ),
                        );
                      },
                      child: const Text(
                        'Add Details',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 50),
                        elevation: 5,
                        backgroundColor: Colors.blueGrey,
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

  Future<void> transportOwner(User user) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('Transport Owner').doc();
      await docUser.set(user.toTransport());
      showToast(message: "Submit Successful");
    } catch (e) {
      showToast(message: 'Some error occurred');
      debugPrint('Error saving transport owner data: $e');
    }
  }
}

class User {
  final String address;
  final int phone;

  User({
    required this.address,
    required this.phone,
  });

  Map<String, dynamic> toTransport() => {
    'address': address,
    'phone': phone,
  };
}
