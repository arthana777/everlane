// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ImageUploadScreen(),
//     );
//   }
// }

// class ImageUploadScreen extends StatefulWidget {
//   @override
//   _ImageUploadScreenState createState() => _ImageUploadScreenState();
// }

// class _ImageUploadScreenState extends State<ImageUploadScreen> {
//   File? _selectedImage;

//   // Image picker method
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF0F4FF), // Light blue background
//       appBar: AppBar(
//         title: Text('Image Upload Example'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Center(
//         child: GestureDetector(
//           onTap: _pickImage,
//           child: Container(
//             width: 300,
//             height: 150,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.blueAccent, width: 1),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                   offset: Offset(2, 2),
//                 ),
//               ],
//             ),
//             child: _selectedImage == null
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.image, size: 50, color: Colors.blueAccent),
//                       SizedBox(height: 10),
//                       Text(
//                         'Drop your image here, or browse',
//                         style: TextStyle(
//                           color: Colors.blueAccent,
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Supports: JPG, JPEG, PNG',
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(
//                       _selectedImage!,
//                       width: double.infinity,
//                       height: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
