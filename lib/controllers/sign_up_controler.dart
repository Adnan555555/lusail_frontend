import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  var selectedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> signup(String name, String email, String password, String role, File? secondImage) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://ec2-18-136-201-110.ap-southeast-1.compute.amazonaws.com/api/api/v1/app/signup'),
    );

    request.fields.addAll({
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    });

    if (selectedImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath('image', selectedImage.value!.path));
    }

    if (secondImage != null) {
      request.files.add(await http.MultipartFile.fromPath('image', secondImage.path));
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Parse the response if needed
      String responseBody = await response.stream.bytesToString();
      print(responseBody);

      // Store data in SharedPreferences
      await saveToSharedPreferences(name, email, password, role);

      print("Data saved to SharedPreferences");
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> saveToSharedPreferences(String name, String email, String password, String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('role', role);
  }
}
