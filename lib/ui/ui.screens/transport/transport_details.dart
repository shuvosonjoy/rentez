import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/model/transportOwnerModel.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class TransportDetails extends StatefulWidget {
  final TransportOwnerModel owner;

  const TransportDetails({super.key, required this.owner});

  @override
  State<TransportDetails> createState() => _TransportDetailsState();
}

class _TransportDetailsState extends State<TransportDetails> {
  Map<String, dynamic>? transportDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransportDetails();
  }

  Future<void> _fetchTransportDetails() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Transport Details')
          .where('ownerId', isEqualTo: widget.owner.id)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() => transportDetails = snapshot.docs.first.data());
      }
    } catch (e) {
      print("Error fetching details: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BackgroundBody(
        child: SafeArea(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : transportDetails == null
              ? const Center(child: Text('No details found'))
              : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Carousel
                _buildImageCarousel(),
                const SizedBox(height: 24),

                // Vehicle Info Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rent & Vehicle Type
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoItem(
                              title: 'Daily Rent',
                              value: '৳${transportDetails!['dailyRent']?.toString() ?? 'N/A'}',
                              isHighlighted: true,
                            ),
                            _buildInfoItem(
                              title: 'Vehicle Type',
                              value: transportDetails!['vehicleType']?.toString() ?? 'N/A',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Vehicle Number & Model
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoItem(
                              title: 'Vehicle Number',
                              value: transportDetails!['vehicleNumber']?.toString() ?? 'N/A',
                            ),
                            _buildInfoItem(
                              title: 'Model',
                              value: transportDetails!['model']?.toString() ?? 'N/A',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Description Section
                _buildSectionTitle('Description'),
                const SizedBox(height: 8),
                _buildDescriptionCard(),
                const SizedBox(height: 24),

                // Owner Information
                _buildSectionTitle('Owner Information'),
                const SizedBox(height: 12),
                _buildOwnerCard(),
                const SizedBox(height: 20),

                // Contact Button
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.phone),
                    label: const Text('Contact Owner'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Add contact functionality
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    // Get image URLs from Firestore
    List<String> imageUrls = (transportDetails?['imageUrls'] as List<dynamic>?)?.cast<String>() ?? [];

    if (imageUrls.isEmpty) {
      return Container(
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: const Center(
          child: Icon(Icons.directions_car, size: 60, color: Colors.grey),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CarouselSlider.builder(
        itemCount: imageUrls.length,
        options: CarouselOptions(
          height: 240,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.75,
          autoPlayInterval: const Duration(seconds: 4),
        ),
        itemBuilder: (context, index, realIndex) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          transportDetails!['description'] ?? 'No description available',
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }

  Widget _buildOwnerCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                'Owner',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, widget.owner.address),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.phone, widget.owner.phone),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required String title,
    required String value,
    bool isHighlighted = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isHighlighted ? Colors.green : Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}