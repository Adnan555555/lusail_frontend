import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_project/Auth/forgotscreen.dart';
import 'package:vehicle_project/Auth/register.dart';
import 'package:vehicle_project/Auth/welcome_screen.dart';

import '../controllers/login/controller.dart';
import '../controllers/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());


  // Animation variables
  late AnimationController _animationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<Offset> _textFieldSlideAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Define the animations
    _logoScaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _textFieldSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
        );

    _buttonScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start animations
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFCABA99),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.090,
                ),
                 Text(
                  '"Ready to buy or sell unique plate fill the form below to get started"',
                  style: TextStyle(fontSize:width*0.04017, fontWeight: FontWeight.bold),
                ),

                // Animated Logo
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: SizedBox(
                    height: height * 0.220,
                    width: width * 0.220,
                    child: Image.asset('assets/images/logo.jpg'),
                  ),
                ),
                SizedBox(height: height * 0.014),

                // Animated Email TextField
                SlideTransition(
                  position: _textFieldSlideAnimation,
                  child: CustomTextField(
                    controller: emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: height * 0.014),

                // Animated Password TextField
                SlideTransition(
                  position: _textFieldSlideAnimation,
                  child: CustomTextField(
                    controller: passwordController,
                    label: 'Password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: height * 0.0200),

                ScaleTransition(
                  scale: _buttonScaleAnimation,
                  child: SizedBox(
                    child: Obx(() {
                      return ElevatedButton(
                        onPressed: _loginController.isLoading.value
                            ? null
                            : () {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar("Error", "All fields are required!");
                          } else {
                            _loginController.login(email, password);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50), // Adjust button size
                        ),
                        child: _loginController.isLoading.value
                            ?  SizedBox(
                          height: height*0.026,
                          width: width*0.046,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                            : const Text("Login"),
                      );
                    }),
                  ),

                ),

                // Register and Forgot Password Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.to(const RegistrationScreen());

                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF5053D5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.014),
                TextButton(
                  onPressed: () {
                    Get.to(const Forgetscreen());
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF5053D5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?) validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFE3DAC9),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF300F1C),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF5053D5),
            width: 2.0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
