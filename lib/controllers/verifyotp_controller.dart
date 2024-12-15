import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OTPController extends GetxController {
  RxBool isLoading = false.obs;

  Future<bool> verifyOTP(String email) async {
    isLoading.value = true;
    var headers = {
      'Cookie': 'your_token_here'  // Consider dynamically fetching the token
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://backend.lusailnumbers.com/api/api/v1/verifyOTP'),
    );
    request.fields.addAll({'email': email});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody); // Decoding the JSON response
        print('OTP Verified Successfully: $data');
        return true; // Success
      } else {
        print('Failed to verify OTP: ${response.reasonPhrase}');
        return false; // Failure
      }
    } catch (e) {
      print('Error in OTP verification: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
