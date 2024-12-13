import 'package:flutter/material.dart';


class RoleSelectorScreen extends StatefulWidget {
  const RoleSelectorScreen({super.key});

  @override
  _RoleSelectorScreenState createState() => _RoleSelectorScreenState();
}

class _RoleSelectorScreenState extends State<RoleSelectorScreen> {
  String selectedRole = ''; // Initially no role is selected.

  void _selectRole(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
   
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _selectRole('Buyer');
            },
            child: Text(
              'Buyer',
              style: TextStyle(
                fontSize: 24,
                color: selectedRole == 'Buyer' ? Colors.blue : Colors.black,
                fontWeight:
                    selectedRole == 'Buyer' ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          SizedBox(height: height*0.024),
          GestureDetector(
            onTap: () {
              _selectRole('Seller');
            },
            child: Text(
              'Seller',
              style: TextStyle(
                fontSize:width*0.5824,
                color: selectedRole == 'Seller' ? Colors.blue : Colors.black,
                fontWeight:
                    selectedRole == 'Seller' ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          SizedBox(height:height*0.0430),
          Text(
            selectedRole.isEmpty
                ? 'Please select a role'
                : 'You selected: $selectedRole',
            style: TextStyle(fontSize: width*0.0520, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
