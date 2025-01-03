import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/get_all_product_model.dart';

class ProductsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Products> productList = <Products>[].obs;

  Future<void> fetchProducts() async {
    isLoading.value = true;

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'GET',
      Uri.parse('https://backend.lusailnumbers.com/api/api/v1/getAllProducts'),
    );
    request.body = json.encode({
      "plateNo": "656788",
      "price": "70000",
      "discount": "0",
    });
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var decoded = json.decode(responseBody);
        var productsModel = GetAllProductsModel.fromJson(decoded);

        productList.value = productsModel.products ?? [];
        print("Products fetched successfully: ${productList.length}");
      } else {
        print("Failed to fetch products: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
