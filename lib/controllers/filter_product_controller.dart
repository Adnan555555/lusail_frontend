import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/filter_product_model.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var productList = <FilterProduct>[].obs;

  // Fetch products from API
  Future<void> fetchProducts() async {
    isLoading.value = true;
    var headers = {
      'Cookie': 'token=your_token_here',
    };

    var request = http.Request(
        'POST',
        Uri.parse('https://backend.lusailnumbers.com/api/api/v1/filteredProducts')
    );
    request.bodyFields = {};
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody) as List;
        productList.value = data.map((product) => FilterProduct.fromJson(product)).toList();
      } else {
        print('Failed to load products: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
