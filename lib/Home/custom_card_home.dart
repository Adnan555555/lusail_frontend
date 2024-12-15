import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_project/Home/detail_description.dart';

import '../controllers/get_all_product.dart';

class CustomCardHome extends StatefulWidget {
  const CustomCardHome({super.key});

  @override
  State<CustomCardHome> createState() => _CustomCardHomeState();
}

class _CustomCardHomeState extends State<CustomCardHome> {
  final ProductsController _productsController = Get.put(ProductsController());

  @override
  void initState() {
    super.initState();
    _productsController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.25,
      child: Obx(() {
        if (_productsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _productsController.productList.length,
          itemBuilder: (context, index) {
            final product = _productsController.productList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  Get.to(const DetailDescription());
                },
                child: Card(
                  color: const Color(0xffFFD200),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.grey[300],
                                height: MediaQuery.of(context).size.height * 0.080,
                                width: MediaQuery.of(context).size.width,
                                child:  const Center(
                                  child:Image(
                                    image: AssetImage("assets/images/qattar.jpg"),
                                  )
                                ),
                              ),
                              Positioned(
                                left: 45,
                                bottom: 20,
                                child: Text(
                                  product.plateNo ?? 'N/A',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          product.sellerName ?? 'Unknown',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${product.price ?? '0'} Q.T",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${product.discountpercent ?? '0'}% off",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                                size: 18,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const Text(
                          'More Info',
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );

      }),
    );
  }
}
