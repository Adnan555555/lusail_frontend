import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_project/Auth/welcome_screen.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
        'POST',
        Uri.parse(
          'http://ec2-18-136-201-110.ap-southeast-1.compute.amazonaws.com/api/api/v1/app/login',
        ),
      );
      request.body = json.encode({
        "email": email,
        "password": password,
      });
      request.headers.addAll(headers);

      log("Request Body: ${request.body}"); // Log the request body

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        log("Response Data: $responseData");

        Get.snackbar("Success", "Logged in successfully!");
        Get.to(() => const WelcomeScreen()); // Navigate to the Welcome Screen
      } else {
        log("Error: ${response.reasonPhrase}");
        Get.snackbar("Error", response.reasonPhrase ?? "Login failed!");
      }
    } catch (e) {
      log("Exception: $e");
      Get.snackbar("Error", "Something went wrong!");
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }
}
