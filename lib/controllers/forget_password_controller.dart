import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordController extends GetxController {
  var isLoading = false.obs;

  Future<void> forgetPassword(String email) async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      var request = http.Request(
        'POST',
        Uri.parse(
          'http://ec2-18-136-201-110.ap-southeast-1.compute.amazonaws.com/api/api/v1/forgetPassword',
        ),
      );
      request.bodyFields = {
        'email': email,
      };
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        Get.snackbar("Success", data['message'] ?? "Password reset successful!");
      } else {
        Get.snackbar("Error", "Request failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong!");
    } finally {
      isLoading.value = false;
    }
  }
}
