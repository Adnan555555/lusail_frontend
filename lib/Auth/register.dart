import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_project/Auth/loginscreen.dart';
import 'package:vehicle_project/Auth/welcome_screen.dart';

import '../controllers/sign_up_controler.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String selectedRole = '';

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _selectRole(String role) {
    setState(() {
      selectedRole = role;
    });
  }

  Future<void> _saveToSharedPreferences(String name, String email, String phone, String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('role', role);
  }

  final SignupController _controller = Get.put(SignupController());
  File? secondImage;

  Future<void> _signupAndNavigate() async {
    String name = _firstNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String phone = _phoneController.text;
    String role = selectedRole;

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await _controller.signup(name, email, password, role, secondImage);
      await _saveToSharedPreferences(name, email, phone, role);
      setState(() {
        isLoading = false;
      });
      Get.off(() => const WelcomeScreen());
      Get.snackbar("Lusail", "SignUp successfully");
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffCABA99),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(width*0.0360),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.060),
                const Text(
                  '"Complete your detail to access exclusive plate number in Qatar"',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.020),
                SizedBox(
                  height: height * 0.250,
                  width: width * 0.250,
                  child: GestureDetector(
                    onTap: () async {
                      await _controller.pickImage();
                    },
                    child: Obx(() => CircleAvatar(
                      radius: 50,
                      backgroundImage: _controller.selectedImage.value != null
                          ? FileImage(_controller.selectedImage.value!)
                          : null,
                      child: _controller.selectedImage.value == null
                          ? const Icon(Icons.add_a_photo, size: 50)
                          : null,
                    )),
                  ),
                ),
                SizedBox(height: height * 0.025),
                _buildTextField('Name', Icons.person, _firstNameController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                }),
                SizedBox(height: height * 0.013),
                _buildTextField(
                  'Email',
                  Icons.email,
                  _emailController,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.014),
                _buildTextField('Phone Number', Icons.phone, _phoneController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) { // Corrected regex
                    return 'Enter a valid 10-digit phone number';
                  }
                  return null;
                }),

                SizedBox(height: height * 0.010),
                _buildTextField('Password', Icons.lock, _passwordController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                }, obscureText: true),
                SizedBox(height: height * 0.010),
                _buildTextField('Confirm Password', Icons.lock_outline, _confirmPasswordController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                }, obscureText: true),
                SizedBox(height: height * 0.024),
                _buildRoleSelection(width, height),
                SizedBox(height: height * 0.024),
                ElevatedButton(
                  onPressed: () => _signupAndNavigate(),

                  child: isLoading
                      ? SizedBox(
                    height: height*0.030,
                        width: width*0.06,
                        child: const CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                      )
                      : const Text('Signup'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const LoginScreen());
                      },
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: Color(0xff3B42DF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, FormFieldValidator<String>? validator, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xffB0A99C)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF300F1C),
            width: 1.5,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: validator,
    );
  }

  Widget _buildRoleSelection(double width, double height) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          padding:  EdgeInsets.symmetric(vertical: height*0.030),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
               Text(
                "Select Your Role",
                style: TextStyle(fontSize: width*0.048, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.014),
              GestureDetector(
                onTap: () => _selectRole('Buyer'),
                child: Text(
                  'Buyer',
                  style: TextStyle(
                    fontSize: width*0.048,
                    color: selectedRole == 'Buyer' ? Colors.blue : Colors.black,
                    fontWeight: selectedRole == 'Buyer' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: height * 0.014),
              GestureDetector(
                onTap: () => _selectRole('Seller'),
                child: Text(
                  'Seller',
                  style: TextStyle(
                    fontSize: width*0.048,
                    color: selectedRole == 'Seller' ? Colors.blue : Colors.black,
                    fontWeight: selectedRole == 'Seller' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
               SizedBox(height: height*0.014),
              Text(
                selectedRole.isEmpty ? 'Please select a role' : 'You selected: $selectedRole',
                style:  TextStyle(fontSize: width*0.048, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
