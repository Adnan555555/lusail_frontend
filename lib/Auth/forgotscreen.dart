import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import '../controllers/forget_password_controller.dart';
import '../controllers/verifyotp_controller.dart';
import 'new_password_screen.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final VerifyOtpController controller = Get.put(VerifyOtpController());

  final TextEditingController otpController = TextEditingController();
  final ForgetPasswordController _controller = Get.put(ForgetPasswordController());

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFCABA99),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(width*0.0360),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                SizedBox(
                  height: height*0.230,
                  width: width*0.450,
                  child: Image.asset('assets/images/logo.jpg'),
                ),
                // Email Input Field
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFE3DAC9),
                    labelText: 'Email',
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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() {
                    return _controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                           onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String email = emailController.text.trim();
                          _controller.forgetPassword(email);
                        }
                        },
                        child: const Text("Send Request"),
                    );
                  }),
                ),
                 SizedBox(height: height*0.012),
                // OTP Input Field
                PinCodeTextField(
                  controller: otpController,
                  highlight: true,
                  highlightColor: Colors.blue,
                  defaultBorderColor: Colors.grey,
                  hasTextBorderColor: Colors.black,
                  maxLength: 4,
                  pinBoxHeight: 40,
                  pinBoxWidth: 30,
                  wrapAlignment: WrapAlignment.center,
                  pinTextStyle: const TextStyle(fontSize: 16.0),
                  onTextChanged: (value) {
                    debugPrint("Current OTP: $value");
                  },
                  onDone: (otp) {
                    Get.snackbar("OTP", "Entered OTP: $otp");
                  },
                ),
                 SizedBox(height:height*0.02520),
                // Verify OTP Button
                Obx(() => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isNotEmpty) {
                      controller.verifyOtp(emailController.text);
                    } else {
                      Get.snackbar('Error', 'Please enter your email',
                          snackPosition: SnackPosition.TOP);
                    }
                  },
                  child: const Text('Verify OTP'),
                )),
                  SizedBox(height: 16),
                //      Obx(() => Text(
                //   'Response: ${controller.otpResponse.value}',
                //   style: const TextStyle(fontSize: 16),
                // )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
