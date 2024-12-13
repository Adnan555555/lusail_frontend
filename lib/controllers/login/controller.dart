import 'package:get/get.dart';
import 'auth.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;  // For managing loading state
  var isLoggedIn = false.obs;  // To track login status

  // Create an instance of AuthService
  final AuthService _authService = AuthService();

  // Login method to call the service
  Future<void> login(String email, String password) async {
    try {
      isLoading(true);  // Set loading to true
      final result = await _authService.login(email, password);  // Call the login method
      isLoggedIn(true);  // Update login status
      Get.snackbar("Success", "Login Successful",
          snackPosition:SnackPosition.TOP
      );
      print(result);  // Handle the result (e.g., storing a token or navigating)
    } catch (e) {
      isLoggedIn(false);  // Update login status if login fails
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading(false);  // Set loading to false after the request is complete
    }
  }
}
