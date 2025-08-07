import 'package:flutter/material.dart';
import 'package:rent_ez/ui/ui.screens/settings_screen.dart';
import 'package:rent_ez/ui/ui.screens/shop/shop_screen.dart';
import 'package:rent_ez/ui/ui.screens/transport/transport_screen.dart';
import 'package:rent_ez/ui/ui.screens/ui.widgets/image_carousel_widget.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

import 'garage/garage_screen.dart';
import 'house/house_screen.dart';
import 'office/office_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Map<String, Color> buttonColors = {
    'HOUSE': const Color(0xFFF9B8D0),
    'SHOP': const Color(0xFFB8E1FF),
    'OFFICE': const Color(0xFFFFD6B8),
    'GARAGE': const Color(0xFFC5E1A5),
    'TRANSPORT': const Color(0xFFE1BEE7),
    'SETTINGS': const Color(0xFFFFF59D),
  };


  final List<String> carouselImages = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
    'assets/images/img4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBody(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                child: Text(
                  "MySylhet",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                    color: Color(0xFF5A2A83),
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              ImageCarousel(
                images: carouselImages,
                height: 180,
                autoScrollDuration: const Duration(seconds: 5),
                showArrows: true,
                autoScroll: true,
              ),

              // TEXT TITLE
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      'Find Your Perfect Space',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.pinkAccent[100],
                        fontFamily: 'PlayfairDisplay',
                        letterSpacing: 0.5,
                      ),
                    ),

                    Container(
                      height: 4,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFC0CB), Color(0xFFDDA0DD)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // CATEGORY GRID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    _buildCategoryButton('HOUSE', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HouseScreen()))),
                    _buildCategoryButton('SHOP', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopScreen()))),
                    _buildCategoryButton('OFFICE', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OfficeScreen()))),
                    _buildCategoryButton('GARAGE', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GarageScreen()))),
                    _buildCategoryButton('TRANSPORT', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TransportScreen()))),
                    _buildCategoryButton('SETTINGS', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()))),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCategoryButton(String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: buttonColors[label],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
              child: _getIconForCategory(label),
            ),
            const SizedBox(height: 15),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconForCategory(String category) {
    switch (category) {
      case 'HOUSE':
        return const Icon(Icons.house_rounded, size: 32, color: Colors.black87);
      case 'SHOP':
        return const Icon(Icons.shopping_cart_rounded, size: 32, color: Colors.black87);
      case 'OFFICE':
        return const Icon(Icons.business_center_rounded, size: 32, color: Colors.black87);
      case 'GARAGE':
        return const Icon(Icons.garage_rounded, size: 32, color: Colors.black87);
      case 'TRANSPORT':
        return const Icon(Icons.directions_car_rounded, size: 32, color: Colors.black87);
      case 'SETTINGS':
        return const Icon(Icons.settings_rounded, size: 32, color: Colors.black87);
      default:
        return const Icon(Icons.category_rounded, size: 32, color: Colors.black87);
    }
  }
}