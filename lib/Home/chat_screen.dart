import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  // FAQ data
  final List<Map<String, String>> faqs = [
    {
      'question': 'Do I need an account to buy or sell number plates?',
      'answer': 'Yes, an account is required to buy or sell number plates.',
    },
    {
      'question': 'How can I list my number plate for sale?',
      'answer':
          'To list your number plate, log in to your account, click on "Post," provide the details, and your plate will be ready for sale.',
    },
    {
      'question': 'Will the app support multiple languages?',
      'answer': 'Yes, the app supports both English and Arabic.',
    },
    {
      'question': 'Is there a fee for listing my number plate?',
      'answer':
          'No, listing is free. However, transaction fees may apply on sales.',
    },
    {
      'question': 'Can I edit my number plate listing after posting it?',
      'answer':
          'Yes, you can edit your listing details anytime from "My Listings."',
    },
    {
      'question': 'Is my personal information shared with other users?',
      'answer':
          'No, your personal information remains private. All communication is handled within the app.',
    },
    {
      'question': 'How do I delete my account if needed?',
      'answer':
          'You can delete your account by going to "View Profile" > "Delete" and selecting the delete option.',
    },
  ];

  FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCABA99),
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: const Color(0xFF5053D5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: faqs.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            final faq = faqs[index - 1];
            return Card(
              color: const Color(0xFFCABA99),
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                title: Text(
                  faq['question']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      faq['answer']!,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_common/get_reset.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:livechatt/livechatt.dart';
//
// class FaqScreen extends StatefulWidget {
//   @override
//   _FaqScreenState createState() => _FaqScreenState();
// }
//
// class _FaqScreenState extends State<FaqScreen> {
//   String _platformVersion = 'Unknown'; // For showing platform version
//   final licenseNoTextController = TextEditingController();
//   final groupIdTextController = TextEditingController();
//   final visitorNameTextController = TextEditingController();
//   final visitorEmailTextController = TextEditingController();
//   final organizationTextController = TextEditingController();
//   final positionTextController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   /// Initialize platform-specific details (e.g., version info)
//   Future<void> initPlatformState() async {
//     String? platformVersion;
//     try {
//       platformVersion = await Livechat.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }
//
//     if (!mounted) return;
//     setState(() {
//       _platformVersion = platformVersion ?? 'Unknown';
//     });
//   }
//
//   /// Start Live Chat
//   Future<void> startLiveChat() async {
//     try {
//       await Livechat.beginChat(
//         licenseNoTextController.text.isEmpty
//             ? 'your-license-number' // Replace with your actual license number
//             : licenseNoTextController.text,
//         groupId: groupIdTextController.text.isEmpty
//             ? 'your-group-id' // Replace with your actual group ID
//             : groupIdTextController.text,
//         visitorName: visitorNameTextController.text,
//         visitorEmail: visitorEmailTextController.text,
//         customParams: {
//           'organization': organizationTextController.text,
//           'position': positionTextController.text,
//         },
//       );
//     } catch (e) {
//       Get.snackbar("Error","Failed to start live chat: $e");
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(content: Text("Failed to start live chat: $e")),
//       // );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         centerTitle: true,
//         elevation: 0.0,
//         title: Text(
//           "Support",
//           style: TextStyle(fontSize: 18, color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTextField("License Number", licenseNoTextController,
//                 isNumeric: true),
//             SizedBox(height: 10),
//             _buildTextField("Group ID", groupIdTextController),
//             SizedBox(height: 10),
//             _buildTextField("Visitor Name", visitorNameTextController),
//             SizedBox(height: 10),
//             _buildTextField("Visitor Email", visitorEmailTextController),
//             SizedBox(height: 10),
//             _buildTextField("Organization", organizationTextController),
//             SizedBox(height: 10),
//             _buildTextField("Position", positionTextController),
//             SizedBox(height: 20),
//             CustomButton(
//               onPress: startLiveChat,
//               title: "Start Live Chat",
//             ),
//             SizedBox(height: 20),
//             Text('Running on: $_platformVersion'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Helper function to build input fields
//   Widget _buildTextField(String label, TextEditingController controller,
//       {bool isNumeric = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label),
//         TextField(
//           keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
//           inputFormatters: isNumeric
//               ? [FilteringTextInputFormatter.digitsOnly]
//               : null,
//           controller: controller,
//         ),
//       ],
//     );
//   }
// }
//
// /// Custom button widget
// class CustomButton extends StatelessWidget {
//   final String title;
//   final VoidCallback onPress;
//
//   const CustomButton({
//     super.key,
//     required this.title,
//     required this.onPress,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.blue[500],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: TextButton(
//         onPressed: onPress,
//         child: Text(
//           title,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

