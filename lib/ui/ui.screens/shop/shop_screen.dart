import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/ui.screens/shop/shop_details.dart';
import 'package:rent_ez/ui/ui.screens/shop/shop_owner.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String? selectedCity;
  String? selectedArea;

  final List<String> shopCities = [
    'Barishal',
    'Chattogram',
    'Dhaka',
    'Khulna',
    'Mymensingh',
    'Rajshahi',
    'Sylhet',
    'Rangpur',
  ];

  final List<String> shopAreas = [
    'Ambarkhana',
    'Arambagh',
    'Bagbari',
    'Barutkhana',
    'Bondar',
    'Chowhatta',
    'Chowkidekhi',
    'Dariapara',
    'Dorga Gate',
    'Electric Supply',
    'Fazil Chisth',
    'Hawapara',
    'Housing Estate',
    'Jollarpar',
    'Kazir Bazar',
    'Kazitula',
    'Korer Para',
    'Kumar para',
    'Kuar par',
    'Lama Bazar',
    'Londoni Road',
    'Laladigir par',
    'Mezor Tila',
    'Mirabazar',
    'Munshi Para',
    'Mirboxtula',
    'Mirer Maidan',
    'Modina Market',
    'Noyasorok',
    'Osmani Medical',
    'Pathantula',
    'Payra',
    'Pir Moholla',
    'Rikabi Bazar',
    'Subidbazar',
    'Sekhghat',
    'Shahi Eidgah',
    'Shibgonj',
    'Subhanighat',
    'Tilaghar',
    'Uposhohar A Block',
    'Uposhohar B Block',
    'Uposhohar C Block',
    'Uposhohar D Block',
    'Uposhohar E Block',
    'Uposhohar G Block',
    'Uposhohar H Block',
    'Uposhohar Plaza',
    'Uposhohor',
    'Zindabazar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/Shop.png',
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
              child: SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Your City',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: shopCities
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            )
                                .toList(),
                            value: selectedCity,
                            onChanged: (value) {
                              setState(() {
                                selectedCity = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 80,
                              width: 150,
                            ),
                            menuItemStyleData: const MenuItemStyleData(height: 40),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ShopOwner()),
                            );
                          },
                          child: const Text(
                            'Shop Owner',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15.0),
                            fixedSize: const Size(80, 70),
                            elevation: 20,
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black26, width: 3),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Your Area',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: shopAreas
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            )
                                .toList(),
                            value: selectedArea,
                            onChanged: (value) {
                              setState(() {
                                selectedArea = value;
                              });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 80,
                              width: 150,
                            ),
                            menuItemStyleData: const MenuItemStyleData(height: 40),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    shopList,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox get shopList {
    return SizedBox(
      child: ListView.separated(
        itemCount: 5,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 150,
            width: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    // You can add an image or container here if needed
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/Shop.png',
                      width: 120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Icon(Icons.location_on, color: Colors.blue),
                            Text(
                              'Subidbazer, Sylhet',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: const [
                            Icon(Icons.phone, color: Colors.grey),
                            Text(
                              '01782163624',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShopDetails(),
                              ),
                            );
                          },
                          child: const Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            fixedSize: const Size(20, 30),
                            elevation: 5,
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black26, width: 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
