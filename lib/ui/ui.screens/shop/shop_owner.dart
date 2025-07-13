import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.screens/shop/shop_add_details.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class ShopOwner extends StatefulWidget {
  const ShopOwner({super.key});

  @override
  State<ShopOwner> createState() => _ShopOwnerState();
}

class _ShopOwnerState extends State<ShopOwner> {
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
          'assets/images/Shop Owner.png',
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          // You might want to add an image or placeholder here
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
                  const SizedBox(height: 16),
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
                        if (addressController.text.isEmpty ||
                            phoneController.text.isEmpty) {
                          showToast(message: "Please fill all fields");
                          return;
                        }
                        final phoneNumber = int.tryParse(phoneController.text);
                        if (phoneNumber == null) {
                          showToast(message: "Please enter a valid phone number");
                          return;
                        }
                        final user = User(
                          address: addressController.text.trim(),
                          phone: phoneNumber,
                        );
                        shopOwner(user);
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
                            builder: (context) => const ShopAddDetails(),
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

  Future<void> shopOwner(User user) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('Shop Owner').doc();
      final shop = user.toShop();

      await docUser.set(shop);

      showToast(message: "Submit Successful");
    } catch (e) {
      showToast(message: 'Some error occurred');
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

  Map<String, dynamic> toShop() => {
    'address': address,
    'phone': phone,
  };
}
