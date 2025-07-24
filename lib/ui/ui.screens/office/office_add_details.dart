import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_ez/ui/global/common/toast.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class OfficeAddDetails extends StatefulWidget {
  final String ownerId;

  const OfficeAddDetails({super.key, required this.ownerId});

  @override
  State<OfficeAddDetails> createState() => _OfficeAddDetailsState();
}

class _OfficeAddDetailsState extends State<OfficeAddDetails> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController monthlyRentController = TextEditingController();
  final TextEditingController officeNoController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController buildingNameController = TextEditingController();
  bool isSubmitting = false;

  List<File> selectedImages = [];
  bool isUploadingImages = false;

  @override
  void dispose() {
    descriptionController.dispose();
    monthlyRentController.dispose();
    officeNoController.dispose();
    floorController.dispose();
    buildingNameController.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage(
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
        });
      }
    } catch (e) {
      showToast(message: "Image picker error: $e");
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> imageUrls = [];
    setState(() => isUploadingImages = true);

    try {
      for (var image in selectedImages) {
        String fileName = 'office_${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';
        Reference storageRef = FirebaseStorage.instance.ref().child('office_images/$fileName');
        UploadTask uploadTask = storageRef.putFile(image);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
      return imageUrls;
    } catch (e) {
      showToast(message: "Upload failed: $e");
      return [];
    } finally {
      setState(() => isUploadingImages = false);
    }
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
                      'Provide Office Information',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Image upload section
                  _buildImageUploadSection(),
                  const SizedBox(height: 20),

                  _buildInputField('Description', descriptionController, maxLines: 3),
                  const SizedBox(height: 20),
                  _buildInputField('Monthly Rent', monthlyRentController, keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  _buildInputField('Office No.', officeNoController),
                  const SizedBox(height: 20),
                  _buildInputField('Floor', floorController),
                  const SizedBox(height: 20),
                  _buildInputField('Building Name', buildingNameController),

                  const SizedBox(height: 40),
                  Center(
                    child: (isSubmitting || isUploadingImages)
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

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Office Images:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Image picker button
        ElevatedButton.icon(
          onPressed: pickImages,
          icon: const Icon(Icons.add_photo_alternate),
          label: const Text('Select Images'),
        ),

        const SizedBox(height: 10),

        // Preview selected images
        if (selectedImages.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Image.file(
                    selectedImages[index],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),

        if (isUploadingImages)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: LinearProgressIndicator(),
          ),
      ],
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
        monthlyRentController.text.isEmpty ||
        officeNoController.text.isEmpty ||
        floorController.text.isEmpty ||
        buildingNameController.text.isEmpty) {
      showToast(message: "Please fill all fields");
      return;
    }

    if (selectedImages.isEmpty) {
      showToast(message: "Please select at least one image");
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final monthlyRent = int.tryParse(monthlyRentController.text);

      if (monthlyRent == null) {
        showToast(message: "Invalid rent amount");
        return;
      }

      // Upload images first
      List<String> imageUrls = await uploadImages();

      if (imageUrls.isEmpty) {
        showToast(message: "Failed to upload images");
        return;
      }

      final details = {
        'ownerId': widget.ownerId,
        'description': descriptionController.text,
        'monthlyRent': monthlyRent,
        'officeNo': officeNoController.text,
        'floor': floorController.text,
        'buildingName': buildingNameController.text,
        'imageUrls': imageUrls, // Store image URLs
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection('Office Details').add(details);
      showToast(message: "Details Submitted Successfully");
      Navigator.pop(context);
    } catch (e) {
      showToast(message: "Error: $e");
    } finally {
      setState(() => isSubmitting = false);
    }
  }
}