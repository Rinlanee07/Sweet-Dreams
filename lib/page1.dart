// import 'package:flutter/material.dart';
// import 'page2.dart';

// void main() {
//   runApp(const SweetDreamsApp());
// }

// class SweetDreamsApp extends StatelessWidget {
//   const SweetDreamsApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SweetDreamsScreen(),
//     );
//   }
// }

// class SweetDreamsScreen extends StatelessWidget {
//   const SweetDreamsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Colors used in the design
//     const backgroundColor = Color(0xFF15294B);
//     const orangeColor = Color(0xFFFFA541);
//     const offWhiteTextColor = Color(0xFFF9EDE7);

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // SWEET DREAMS text with flower
//                 Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Text(
//                       "SWEET\nDREAMS",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 56,
//                         fontWeight: FontWeight.w900,
//                         color: orangeColor,
//                         letterSpacing: 2,
//                         shadows: const [
//                           Shadow(
//                             offset: Offset(0, 3),
//                             blurRadius: 3,
//                             color: Colors.black38,
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Flower on top right of the letter S in DREAMS (approximate position)
//                     Positioned(right: -10, top: 8, child: _FlowerWidget()),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//                 const Text(
//                   "Make you beautiful everyday",
//                   style: TextStyle(
//                     color: Color(0xFFD0BEB3),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Dots indicator row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _DotWidget(color: offWhiteTextColor),
//                     _DotWidget(color: Color(0xFFB7A79C)),
//                     _DotWidget(color: Color(0xFF9F8E84)),
//                     _DotWidget(color: Color(0xFF8E7D74)),
//                     _DotWidget(color: Color(0xFF7D6C63)),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//                 // GET STARTED button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SweetDreamsSecondPage(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: orangeColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       elevation: 5,
//                       shadowColor: Colors.black38,
//                     ),
//                     child: const Text(
//                       "GET STARTED",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 18,
//                         letterSpacing: 2,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Small dot circle widget
// class _DotWidget extends StatelessWidget {
//   final Color color;

//   const _DotWidget({required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       width: 14,
//       height: 14,
//       decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//     );
//   }
// }

// // Flower widget to simulate the pink flower with eyes and legs
// class _FlowerWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     const petalColor = Color(0xFFF06AB6);
//     const centerColor = Color(0xFFFFE583);
//     const eyeWhite = Colors.white;
//     const eyeBlack = Colors.black;

//     return SizedBox(
//       width: 70,
//       height: 70,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           // Petals: 8 pink circles around center
//           for (int i = 0; i < 8; i++)
//             Positioned(
//               left:
//                   27 +
//                   20 *
//                       (i == 1 || i == 2
//                           ? 0.5
//                           : (i == 3 || i == 4
//                                 ? 1
//                                 : (i == 5 || i == 6 ? 0.5 : 0))),
//               top:
//                   27 +
//                   20 *
//                       (i == 0 || i == 7
//                           ? 0.5
//                           : (i == 1 || i == 6
//                                 ? 0
//                                 : (i == 2 || i == 5 ? 0.5 : 1))),
//               child: Transform.rotate(
//                 angle: i * 3.1415926535 / 4,
//                 child: Container(
//                   width: 24,
//                   height: 24,
//                   decoration: const BoxDecoration(
//                     color: petalColor,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           // Center circle (flower face)
//           Positioned(
//             left: 22,
//             top: 22,
//             child: Container(
//               width: 28,
//               height: 28,
//               decoration: BoxDecoration(
//                 color: centerColor,
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.orange, width: 1.5),
//               ),
//               child: Stack(
//                 children: [
//                   // Eyes
//                   Positioned(
//                     left: 6,
//                     top: 8,
//                     child: Container(
//                       width: 6,
//                       height: 6,
//                       decoration: const BoxDecoration(
//                         color: eyeWhite,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Align(
//                         alignment: Alignment.center,
//                         child: CircleAvatar(
//                           radius: 2,
//                           backgroundColor: eyeBlack,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 6,
//                     top: 8,
//                     child: Container(
//                       width: 6,
//                       height: 6,
//                       decoration: const BoxDecoration(
//                         color: eyeWhite,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Align(
//                         alignment: Alignment.center,
//                         child: CircleAvatar(
//                           radius: 2,
//                           backgroundColor: eyeBlack,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Smile
//                   Positioned(
//                     bottom: 6,
//                     left: 6,
//                     right: 6,
//                     child: Container(
//                       height: 6,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(4),
//                           bottomRight: Radius.circular(4),
//                         ),
//                       ),
//                       child: CustomPaint(painter: _SmilePainter()),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Legs (small yellow legs with black tips)
//           Positioned(left: 5, bottom: -10, child: _LegWidget()),
//           Positioned(right: 5, bottom: -10, child: _LegWidget()),
//         ],
//       ),
//     );
//   }
// }

// // Legs widget for flower's legs
// class _LegWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     const legColor = Color(0xFFECFF82);
//     const tipColor = Color(0xFF98A73D);

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 6,
//           height: 18,
//           decoration: BoxDecoration(
//             color: legColor,
//             borderRadius: BorderRadius.circular(3),
//           ),
//         ),
//         Container(
//           width: 10,
//           height: 6,
//           decoration: BoxDecoration(
//             color: tipColor,
//             borderRadius: BorderRadius.circular(3),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Painter for the smile arc under flower's eyes
// class _SmilePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black87
//       ..strokeWidth = 1.5
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
//     canvas.drawArc(rect, 0, 3.14, false, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
