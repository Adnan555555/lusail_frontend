// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vehicle_project/Home/detail_description.dart';
// import 'package:vehicle_project/Home/home.dart';
// import 'package:vehicle_project/Home/popular.dart';
// import 'package:vehicle_project/profileScreen/account_screen.dart';
// import 'package:vehicle_project/Home/chat_screen.dart';
// import 'package:vehicle_project/Home/listing.dart';
//
// import '../controllers/get_all_product.dart';
//
// class VIP extends StatefulWidget {
//   const VIP({super.key});
//
//   @override
//   _VIPState createState() => _VIPState();
// }
//
// class _VIPState extends State<VIP> {
//   final ProductsController _productsController = Get.put(ProductsController());
//   int _currentIndex = 0;
//   bool _isExpanded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _productsController.fetchProducts();
//   }
//
//   void _loadMoreProducts() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//     });
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//   void navigatetodetailscreens(int index) {
//     switch (index) {
//       case 0:
//        Get.to(const DetailDescription());
//         break;
//       case 1:
//         Get.to(const DetailDescription());
//         break;
//       case 2:
//         Get.to(const DetailDescription());
//         break;
//       case 3:
//         Get.to(const DetailDescription());
//         break;
//       case 4:
//         Get.to(const DetailDescription());
//         break;
//       case 5:
//         Get.to(const DetailDescription());
//         break;
//       case 6:
//         Get.to(const DetailDescription());
//         break;
//       default:
//         break;
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffCABA99),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffCABA99),
//         title: const Text('VIP Category'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               FutureBuilder(
//                 future: _productsController.fetchProducts(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text('Error: ${snapshot.error}'),
//                     );
//                   } else {
//                     final productList = _productsController.productList;
//
//                     if (productList.isEmpty) {
//                       return const Center(child: Text('No products available'));
//                     }
//
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GridView.builder(
//
//                         shrinkWrap: true, // Ensure GridView takes only required space
//                         physics: const NeverScrollableScrollPhysics(), // Disable scrolling for GridView
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 8.0,
//                           mainAxisSpacing: 8.0,
//                           childAspectRatio: 0.64,
//                         ),
//                         itemCount: productList.length,
//                         itemBuilder: (context, index) {
//                           final product = productList[index];
//                           return InkWell(
//                             onTap: (){
//                               navigatetodetailscreens(index);
//                             },
//                             child: Card(
//                               color: const Color(0xffFFD200),
//                               elevation: 3,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       color: Colors.grey[300],
//                                       height: MediaQuery.of(context).size.height * 0.080,
//                                       width: MediaQuery.of(context).size.width,
//                                       child: Center(
//                                         child: Stack(
//                                           children: [
//                                             const Image(
//                                               image: AssetImage("assets/images/qattar.jpg"),
//                                               width: double.infinity,
//                                               fit: BoxFit.cover,
//                                             ),
//                                             Positioned(
//                                               left: 45,
//                                               bottom: 20,
//                                               child: Text(
//                                                 product.plateNo ?? 'N/A',
//                                                 style: const TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 10,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8.0),
//                                     Text(
//                                       product.sellerName ?? 'Unknown',
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     Text(
//                                       "${product.price ?? '0'} Q.T",
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     Text(
//                                       "${product.discountpercent ?? '0'}% off",
//                                       style: const TextStyle(
//                                         fontSize: 10,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const Text(
//                                           'Some Detail',
//                                           style: TextStyle(fontSize: 10, color: Colors.black),
//                                         ),
//                                         IconButton(
//                                           icon: const Icon(Icons.favorite_border, color: Colors.black, size: 18),
//                                           onPressed: () {},
//                                         ),
//                                       ],
//                                     ),
//                                     const Text(
//                                       'More Info',
//                                       style: TextStyle(fontSize: 10, color: Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 },
//               ),
//               // ElevatedButton(
//               //   onPressed: _loadMoreProducts,
//               //   child: Text(_isExpanded ? 'Show Less' : 'Load More'),
//               // ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 1.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildBottomNavItem(Icons.home, 'Home', 0, const HomePageScreen()),
//             _buildBottomNavItem(Icons.chat_bubble_outline_outlined, 'Chat', 1, FaqScreen()),
//             const SizedBox(width: 15),
//             _buildBottomNavItem(Icons.list, 'My List', 2, const CustomCardList()),
//             _buildBottomNavItem(Icons.person, 'Account', 3, const MyAccount()),
//           ],
//         ),
//       ),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [Colors.red, Color(0xFF3A1D6F), Color.fromARGB(255, 49, 4, 160), Color(0xFFAF121F), Colors.brown, Color(0xFFAF121F)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: CircleAvatar(
//                 radius: 28,
//                 backgroundColor: const Color(0xFFD9D9D9),
//                 child: IconButton(
//                   icon: const Icon(Icons.add, color: Colors.black),
//                   onPressed: () {
//                     Get.to(const Popular());
//                   },
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'Sell',
//             style: TextStyle(color: Colors.black, fontSize: 18),
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
//
//   Widget _buildBottomNavItem(IconData icon, String label, int index, Widget? page) {
//     final isSelected = index == _currentIndex;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _currentIndex = index;
//         });
//         if (page != null) {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => page));
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: isSelected ? const Color(0xff300F1C) : Colors.black),
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? const Color(0xff300F1C) : Colors.grey,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
