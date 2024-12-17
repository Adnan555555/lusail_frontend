import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_project/Home/custom_card_home.dart';
import 'package:vehicle_project/Home/golden.dart';
import 'package:vehicle_project/Home/normal.dart';
import 'package:vehicle_project/Home/silver.dart';
import 'package:vehicle_project/Home/vip.dart';

class ImageWithTextOverlay extends StatefulWidget {
  const ImageWithTextOverlay({super.key});

  @override
  _ImageWithTextOverlayState createState() => _ImageWithTextOverlayState();
}

class _ImageWithTextOverlayState extends State<ImageWithTextOverlay> {
  List<String>avatarImages = [
    'assets/images/normal.png',
    'assets/images/silver.png',
    'assets/images/gold.png',
    'assets/images/vip.png',
  ];
  List<String>browseCategory = [
    "Normal",
    "Silver",
    "Gold",
    "VIP"
  ];

  final List<Map<String, String>> avatarData = const [
    {'image': 'assets/images/normal.png', 'name': 'Normal', 'route': 'normal'},
    {'image': 'assets/images/silver.png', 'name': 'Silver', 'route': 'silver'},
    {'image': 'assets/images/gold.png', 'name': 'Gold', 'route': 'gold'},
    {'image': 'assets/images/vip.png', 'name': 'VIP', 'route': 'vip'},
  ];
List<String>category=['normal','silver','gold','vip'];
  // Sample data for products to be displayed
  List<Widget> productCards = List.generate(5, (index) {
    return const CustomCardHome(); // Just example cards, you can replace with actual content.
  });

  bool _showMore = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SizedBox(
                  width: width,
                  height: height*0.240,
                  child: Image.asset(
                    'assets/images/car.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
           SizedBox(
            height: height*0.025,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Browse Category',
                style: TextStyle(
                  fontSize: width*0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
           SizedBox(height:height*0.0020),
          SizedBox(
            height: height*0.100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: avatarImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => Get.to(() => Category(category: category[index])),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                avatarImages[index],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(browseCategory[index]),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children:
              //
              //   avatarData.map((data) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 6),
              //       child: GestureDetector(
              //         onTap: () {
              //           // Navigate to respective screen based on the route
              //           switch (data['route']) {
              //             case 'normal':
              //               Get.to(Normal(category: ,));
              //
              //               break;
              //             case 'silver':
              //               Get.to(Silver());
              //
              //               break;
              //             case 'gold':
              //               Get.to(Golden());
              //               break;
              //             case 'vip':
              //               Get.to(VIP());
              //               break;
              //             default:
              //               // Handle any unexpected cases
              //               break;
              //           }
              //         },
              //         child: Column(
              //           children: [
              //             CircleAvatar(
              //               radius: 30,
              //               backgroundImage: AssetImage(data['image']!),
              //             ),
              //             const SizedBox(height: 6),
              //             Text(
              //               data['name']!,
              //               style: const TextStyle(fontSize: 14),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   }).toList(),
              // ),
            ),
          ),

          const SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'All Products',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ...productCards.take(_showMore ? productCards.length : 3),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showMore = !_showMore;
              });
            },
            child: Text(_showMore ? 'Show Less' : 'Load More'),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
