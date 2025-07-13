import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/ui/ui.screens/office/office_details.dart';
import 'package:rent_ez/ui/ui.screens/office/office_owner.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({super.key});

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  String? selectedValue;
  final List<String> officeitems = [
    'Barishal', 'Chattogram', 'Dhaka', 'Khulna',
    'Mymensingh', 'Rajshahi', 'Sylhet', 'Rangpur',
  ];

  final List<String> officeitems1 = [
    'Ambarkhana', 'Arambagh', 'Bagbari', 'Barutkhana', 'Bondar', 'Chowhatta', 'Chowkidekhi', 'Dariapara', 'Dorga Gate', 'Electric Supply',
    'Fazil Chisth', 'Hawapara', 'Housing Estate', 'Jollarpar', 'Kazir Bazar', 'Kazitula', 'Korer Para', 'Kumar para', 'Kuar par',
    'Lama Bazar', 'Londoni Road', 'Laladigir par', 'Mezor Tila', 'Mirabazar', 'Munshi Para', 'Mirboxtula', 'Mirer Maidan', 'Modina Market',
    'Noyasorok', 'Osmani Medical', 'Pathantula', 'Payra', 'Pir Moholla', 'Rikabi Bazar', 'Subidbazar', 'Sekhghat', 'Shahi Eidgah',
    'Shibgonj', 'Subhanighat', 'Tilaghar', 'Uposhohar A Block', 'Uposhohar B Block', 'Uposhohar C Block', 'Uposhohar D Block',
    'Uposhohar E Block', 'Uposhohar G Block', 'Uposhohar H Block', 'Uposhohar Plaza', 'Uposhohor', 'Zindabazar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/Office.png',
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
                            items: officeitems
                                .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item, style: const TextStyle(fontSize: 15)),
                            ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
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
                              MaterialPageRoute(builder: (context) => const OfficeOwner()),
                            );
                          },
                          child: const Text(
                            'Office Owner',
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
                            items: officeitems1
                                .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item, style: const TextStyle(fontSize: 14)),
                            ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
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
                    Column(
                      children: const [
                        SizedBox(height: 10),
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    officeList,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox get officeList {
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/images/Office.png'),
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
                            SizedBox(width: 5),
                            Text('Subidbazer, Sylhet', overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: const [
                            Icon(Icons.phone, color: Colors.grey),
                            SizedBox(width: 5),
                            Text('01782163624', overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: null, // Will be overridden below
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            fixedSize: const Size(90, 30),
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
