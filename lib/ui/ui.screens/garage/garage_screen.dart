import 'package:flutter/material.dart';
import 'package:rent_ez/ui/ui.screens/garage/garage_details.dart';
import 'package:rent_ez/ui/ui.screens/garage/garage_owner.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  String? selectedCity;
  String? selectedArea;

  final List<String> garageItems = [
    'Barishal', 'Chattogram', 'Dhaka', 'Khulna', 'Mymensingh', 'Rajshahi', 'Sylhet', 'Rangpur',
  ];

  final List<String> garageAreas = [
    'Ambarkhana', 'Arambagh', 'Bagbari', 'Barutkhana', 'Bondar', 'Chowhatta', 'Chowkidekhi',
    'Dariapara', 'Dorga Gate', 'Electric Supply', 'Fazil Chisth', 'Hawapara', 'Housing Estate',
    'Jollarpar', 'Kazir Bazar', 'Kazitula', 'Korer Para', 'Kumar para', 'Kuar par', 'Lama Bazar',
    'Londoni Road', 'Laladigir par', 'Mezor Tila', 'Mirabazar', 'Munshi Para', 'Mirboxtula',
    'Mirer Maidan', 'Modina Market', 'Noyasorok', 'Osmani Medical', 'Pathantula', 'Payra',
    'Pir Moholla', 'Rikabi Bazar', 'Subidbazar', 'Sekhghat', 'Shahi Eidgah', 'Shibgonj',
    'Subhanighat', 'Tilaghar', 'Uposhohar A Block', 'Uposhohar B Block', 'Uposhohar C Block',
    'Uposhohar D Block', 'Uposhohar E Block', 'Uposhohar G Block', 'Uposhohar H Block',
    'Uposhohar Plaza', 'Uposhohor', 'Zindabazar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/Garage.png',
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
                          items: garageItems
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ))
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
                            MaterialPageRoute(builder: (context) => const GarageOwner()),
                          );
                        },
                        child: const Text(
                          'Garage Owner',
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
                          items: garageAreas
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ))
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
                  Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  garageList,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox get garageList {
    return SizedBox(
      child: ListView.separated(
        itemCount: 5,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      child: Image.asset('assets/images/Garage.png', width: 120, fit: BoxFit.cover),
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
                            SizedBox(width: 5),
                            Text(
                              'Subidbazar, Sylhet',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: const [
                            Icon(Icons.phone, color: Colors.grey),
                            SizedBox(width: 5),
                            Text(
                              '01782163624',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: null, // Set your navigation to GarageDetails here
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
                            fixedSize: const Size(80, 30),
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
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      ),
    );
  }
}
