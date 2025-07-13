import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class ShopAddDetails extends StatefulWidget {
  const ShopAddDetails({super.key});

  @override
  State<ShopAddDetails> createState() => _ShopAddDetailsState();
}

class _ShopAddDetailsState extends State<ShopAddDetails> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController shopRentController = TextEditingController();
  final TextEditingController shopNoController = TextEditingController();
  final TextEditingController roadNoController = TextEditingController();
  final TextEditingController areaDetailsController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    shopRentController.dispose();
    shopNoController.dispose();
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
                      'Provide Shop Information',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(descriptionController, 'Description'),
                  const SizedBox(height: 20),
                  _buildNumberField(shopRentController, 'Shop Rent'),
                  const SizedBox(height: 20),
                  _buildTextField(shopNoController, 'Shop no.'),
                  const SizedBox(height: 20),
                  _buildNumberField(roadNoController, 'Road No.'),
                  const SizedBox(height: 20),
                  _buildTextField(areaDetailsController, 'Area Details'),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
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

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }

  Widget _buildNumberField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }

  void _submitForm() {
    if (descriptionController.text.isEmpty ||
        shopRentController.text.isEmpty ||
        shopNoController.text.isEmpty ||
        roadNoController.text.isEmpty ||
        areaDetailsController.text.isEmpty) {
      showToast(message: 'Please fill all fields');
      return;
    }

    final shopRent = int.tryParse(shopRentController.text);
    final roadNo = int.tryParse(roadNoController.text);

    if (shopRent == null || roadNo == null) {
      showToast(message: 'Please enter valid numbers for Shop Rent and Road No.');
      return;
    }

    final user = User(
      description: descriptionController.text.trim(),
      shopRent: shopRent,
      shopNo: shopNoController.text.trim(),
      roadNo: roadNo,
      areaDetails: areaDetailsController.text.trim(),
    );

    shopAddDetails(user);
  }

  Future<void> shopAddDetails(User user) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('Shop Add Details').doc();
      final shop = user.toShop();
      await docUser.set(shop);
      showToast(message: "Submit Successful");
    } catch (e) {
      showToast(message: 'Some error occurred');
    }
  }
}

class User {
  final String description;
  final int shopRent;
  final String shopNo;
  final int roadNo;
  final String areaDetails;

  User({
    required this.description,
    required this.shopRent,
    required this.shopNo,
    required this.roadNo,
    required this.areaDetails,
  });

  Map<String, dynamic> toShop() => {
    'description': description,
    'shopRent': shopRent,
    'shopNo': shopNo,
    'roadNo': roadNo,
    'areaDetails': areaDetails,
  };
}
