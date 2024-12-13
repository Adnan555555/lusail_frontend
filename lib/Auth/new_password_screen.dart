import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_project/Auth/loginscreen.dart';

class Newpassword extends StatefulWidget {
  const Newpassword({super.key});

  @override
  State<Newpassword> createState() => _NewpasswordState();
}

class _NewpasswordState extends State<Newpassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _currentPasswordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffCABA99),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height*0.23,
                width: width*0.25,
                child: Image.asset('assets/images/logo.jpg'),
              ),
               Text(
                'Create New Password',
                style: TextStyle(fontSize: width*0.050, color: Colors.black),
                textAlign: TextAlign.center,
              ),
               SizedBox(height:height*0.025),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureText1,
                obscuringCharacter: '.',
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: 'Enter New Password',
                  border: const OutlineInputBorder(),
                  counterText: '',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText1 ? Icons.visibility : Icons.visibility_off,
                      size: 15,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText1 = !_obscureText1;
                      });
                    },
                  ),
                ),
              ),
               SizedBox(height: height*0.012),
              TextFormField(
                controller: _confirmedPasswordController,
                obscureText: _obscureText2,
                obscuringCharacter: '.',
                maxLength: 8,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFE3DAC9),
                  labelText: 'Confirm Password',
                  border: const OutlineInputBorder(),
                  counterText: '',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText2 ? Icons.visibility : Icons.visibility_off,
                      size: 15,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText2 = !_obscureText2;
                      });
                    },
                  ),
                ),
              ),

              SizedBox(height: height*0.012),
              ElevatedButton(
                onPressed: () {
                  Get.to(LoginScreen());
                },
                style: ElevatedButton.styleFrom(
                  padding:
                       EdgeInsets.symmetric(horizontal: width*0.020, vertical:height*0.02015),
                  backgroundColor: const Color(0xffFBFF1F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:  Text(
                  'Login',
                  style: TextStyle(fontSize: width*0.045, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
