import 'package:flutter/material.dart';
import 'package:rent_ez/ui/ui.screens/house/house_details.dart';
import 'package:rent_ez/ui/ui.screens/house/house_owner.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HouseScreen extends StatefulWidget {
  const HouseScreen({super.key});

  @override
  State<HouseScreen> createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  String? selectedCity;
  String? selectedArea;

  final List<String> cityItems = [
    'Barishal', 'Chattogram', 'Dhaka', 'Khulna', 'Mymensingh', 'Rajshahi', 'Sylhet', 'Rangpur',
  ];

  final List<String> areaItems = [
    'Ambarkhana', 'Arambagh', 'Bagbari', 'Barutkhana', 'Bondar', 'Chowhatta', 'Chowkidekhi', 'Dariapara', 'Dorga Gate', 'Electric Supply', 'Fazil Chisth', 'Hawapara',
    'Housing Estate', 'Jollarpar', 'Kazir Bazar', 'Kazitula', 'Korer Para', 'Kumar para', 'Kuar par', 'Lama Bazar', 'Londoni Road', 'Laladigir par', 'Mezor Tila', 'Mirabazar',
    'Munshi Para', 'Mirboxtula', 'Mirer Maidan', 'Modina Market', 'Noyasorok', 'Osmani Medical', 'Pathantula', 'Payra', 'Pir Moholla', 'Rikabi Bazar', 'Subidbazar', 'Sekhghat',
    'Shahi Eidgah', 'Shibgonj', 'Subhanighat', 'Tilaghar', 'Uposhohar A Block', 'Uposhohar B Block', 'Uposhohar C Block', 'Uposhohar D Block', 'Uposhohar E Block',
    'Uposhohar G Block', 'Uposhohar H Block', 'Uposhohar Plaza', 'Uposhohor', 'Zindabazar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/House.png',
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
                  /// Dropdown & House Owner Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Text(
                            'Select Your City',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                          ),
                          items: cityItems.map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: const TextStyle(fontSize: 15)),
                          )).toList(),
                          value: selectedCity,
                          onChanged: (String? value) {
                            setState(() => selectedCity = value);
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const HouseOwner(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          fixedSize: const Size(80, 70),
                          elevation: 20,
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.black26, width: 3),
                        ),
                        child: const Text(
                          'House Owner',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Area Dropdown
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Your Area',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                      items: areaItems.map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: const TextStyle(fontSize: 14)),
                      )).toList(),
                      value: selectedArea,
                      onChanged: (String? value) {
                        setState(() => selectedArea = value);
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 80,
                        width: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(height: 40),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'View All',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Colors.black),
                  ),

                  const SizedBox(height: 10),
                  houseListView,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox get houseListView {
    return SizedBox(
      child: ListView.separated(
        itemCount: 5,
        primary: false,
        shrinkWrap: true,
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
                    child: Image.asset('assets/images/Building.png', width: 120),
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
                            SizedBox(width: 4),
                            Text('Subidbazer, Sylhet', overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: const [
                            Icon(Icons.phone, color: Colors.grey),
                            SizedBox(width: 4),
                            Text('01782163624', overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const HouseDetails(),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            fixedSize: const Size(90, 35),
                            elevation: 5,
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black26, width: 2),
                          ),
                          child: const Text(
                            'Details',
                            style: TextStyle(fontWeight: FontWeight.w900),
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
