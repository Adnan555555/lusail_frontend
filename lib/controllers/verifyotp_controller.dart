import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerifyOtpController extends GetxController {
  var isLoading = false.obs;
  var otpResponse = ''.obs;

  Future<void> verifyOtp(String email) async {
    isLoading.value = true;
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3NWFhYTM2NTNhNDhlM2U4NmU0NDcwYyIsImlhdCI6MTczNDE4MTIzOCwiZXhwIjoxNzM1NDc3MjM4fQ.pedBCCO3OTs-knScTAbHVVYZM5aooBsIKvhrDnbyiMI'
    };
    var request = http.Request('POST', Uri.parse('https://backend.lusailnumbers.com/api/api/v1/verifyotp'));
    request.bodyFields = {
      'email': email
    };
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        otpResponse.value = await response.stream.bytesToString();
        Get.snackbar('Success', 'OTP verified successfully',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        otpResponse.value = response.reasonPhrase ?? 'Error';
        Get.snackbar('Error', 'Failed to verify OTP',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      otpResponse.value = 'Exception: $e';
      Get.snackbar('Error', 'An error occurred',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
