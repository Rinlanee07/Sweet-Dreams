// import 'package:flutter/material.dart';

// // Entry point of the app
// void main() {
//   runApp(SleepApp());
// }

// class SleepApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sleep App',
//       theme: ThemeData(
//         fontFamily: 'Comfortaa', // Use a friendly font similar to images
//         scaffoldBackgroundColor: Color(0xFF16234B),
//         primaryColor: Color(0xFFFFD8A9),
//         highlightColor: Colors.transparent,
//         splashColor: Colors.transparent,
//         textTheme: TextTheme(
//           bodyText2: TextStyle(color: Colors.white),
//         ),
//       ),
//       home: HomePage(),
//       routes: {
//         SleepGoalsPage.routeName: (_) => SleepGoalsPage(),
//       },
//     );
//   }
// }

// // ====== Home Page ======
// class HomePage extends StatelessWidget {
//   final Color backgroundColorTop = Color(0xFFF7ECE7);
//   final Color backgroundColorBottom = Color(0xFF16234B);
//   final Color bottomBarColor = Color(0xFFFFD8A9);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColorTop,
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               // Top section with cat image & dots
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//                 decoration: BoxDecoration(
//                   color: backgroundColorTop,
//                   borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(32),
//                     bottomLeft: Radius.circular(32),
//                   ),
//                 ),
//                 child: SafeArea(
//                   bottom: false,
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF9A887F)),
//                             onPressed: () {
//                               // Back action or nothing on home page
//                             },
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 8),
//                       // Cat Image widget with circular clipping & drop shadow
//                       Container(
//                         decoration: BoxDecoration(boxShadow: [
//                           BoxShadow(
//                               color: Colors.black.withOpacity(0.15),
//                               offset: Offset(0, 4),
//                               blurRadius: 4)
//                         ]),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(32),
//                           child: Image.asset(
//                             'assets/cat.png',
//                             height: 180,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 12),
//                       // Page indicators
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _IndicatorDot(active: true),
//                           SizedBox(width: 6),
//                           _IndicatorDot(active: false),
//                           SizedBox(width: 6),
//                           _IndicatorDot(active: false),
//                           SizedBox(width: 6),
//                           _IndicatorDot(active: false),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Bottom navy blue expanded container
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   color: backgroundColorBottom,
//                   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                   child: Column(
//                     children: [
//                       Text(
//                         'MENU',
//                         style: TextStyle(
//                           color: Color(0xFFF7ECE7),
//                           fontWeight: FontWeight.w500,
//                           fontSize: 24,
//                           letterSpacing: 2,
//                           fontFamily: 'Comfortaa',
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       Expanded(
//                         child: GridView.count(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 24,
//                           crossAxisSpacing: 24,
//                           children: [
//                             _MenuButton(
//                               label: 'Sleep Tracking',
//                               assetImage: 'assets/bear_sleep.png',
//                               onTap: () {
//                                 // TODO: Add routing
//                               },
//                             ),
//                             _MenuButton(
//                               label: 'Sleep Statistics',
//                               assetImage: 'assets/sleep_stats.png',
//                               onTap: () {
//                                 // TODO: Add routing
//                               },
//                             ),
//                             _MenuButton(
//                               label: 'Sleep Mood',
//                               assetImage: 'assets/sleep_mood.png',
//                               onTap: () {
//                                 // TODO: Add routing
//                               },
//                             ),
//                             _MenuButton(
//                               label: 'sleep Goals',
//                               assetImage: 'assets/sleep_goals.png',
//                               onTap: () {
//                                 Navigator.pushNamed(context, SleepGoalsPage.routeName);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Bottom navigation bar (Custom)
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               color: bottomBarColor,
//               padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(Icons.notifications_none_outlined, color: Color(0xFF4B3F3F)),
//                   Icon(Icons.home_outlined, color: Color(0xFF4B3F3F)),
//                   Icon(Icons.favorite_outline, color: Color(0xFFB76E6E)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Indicator dot for page view on home page top
// class _IndicatorDot extends StatelessWidget {
//   final bool active;
//   const _IndicatorDot({this.active = false});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: active ? 12 : 8,
//       height: active ? 12 : 8,
//       decoration: BoxDecoration(
//         color: active ? Color(0xFFFFD8A9) : Color(0xFFCDC4B2),
//         shape: BoxShape.circle,
//       ),
//     );
//   }
// }

// // Menu button widget with circular icon and label
// class _MenuButton extends StatelessWidget {
//   final String label;
//   final String assetImage;
//   final VoidCallback onTap;

//   const _MenuButton({
//     required this.label,
//     required this.assetImage,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         customBorder: CircleBorder(),
//         onTap: onTap,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CircleAvatar(
//               backgroundColor: Color(0xFFFFD8A9),
//               radius: 48,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Image.asset(assetImage,
//                     height: 56, fit: BoxFit.contain),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               label,
//               style: TextStyle(
//                 color: Color(0xFFF7ECE7),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ===== Sleep Goals Page =====
// class SleepGoalsPage extends StatefulWidget {
//   static const String routeName = '/sleep-goals';

//   @override
//   _SleepGoalsPageState createState() => _SleepGoalsPageState();
// }

// class _SleepGoalsPageState extends State<SleepGoalsPage> {
//   final Color backgroundColor = Color(0xFF16234B);
//   final Color topBarColor = Color(0xFFFFD8A9);

//   // Selected days - use Map to track selection
//   Map<String, bool> selectedDays = {
//     'S': false,
//     'M': true,
//     'T': true,
//     'W': true,
//     'T2': true,
//     'F': true,
//     'S2': false,
//   };

//   TimeOfDay bedtime = TimeOfDay(hour: 22, minute: 30);
//   TimeOfDay wakeupTime = TimeOfDay(hour: 6, minute: 30);

//   @override
//   Widget build(BuildContext context) {
//     double totalSleepHours = _calculateSleepHours();

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top app bar
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               height: 56,
//               color: topBarColor,
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       Icons.arrow_back_ios_new,
//                       color: backgroundColor,
//                       size: 20,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Expanded(
//                     child: Text(
//                       'Sleep Goals',
//                       style: TextStyle(
//                         color: backgroundColor,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 20,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(width: 48), // spacing to balance back button
//                 ],
//               ),
//             ),

//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Choose days label + day selector
//                     Text(
//                       'Choose days',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 16,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _DaySelector(
//                           label: 'S',
//                           selected: selectedDays['S']!,
//                           onTap: () => _toggleDay('S'),
//                         ),
//                         _DaySelector(
//                           label: 'M',
//                           selected: selectedDays['M']!,
//                           onTap: () => _toggleDay('M'),
//                         ),
//                         _DaySelector(
//                           label: 'T',
//                           selected: selectedDays['T']!,
//                           onTap: () => _toggleDay('T'),
//                         ),
//                         _DaySelector(
//                           label: 'W',
//                           selected: selectedDays['W']!,
//                           onTap: () => _toggleDay('W'),
//                         ),
//                         _DaySelector(
//                           label: 'T',
//                           selected: selectedDays['T2']!,
//                           onTap: () => _toggleDay('T2'),
//                         ),
//                         _DaySelector(
//                           label: 'F',
//                           selected: selectedDays['F']!,
//                           onTap: () => _toggleDay('F'),
//                         ),
//                         _DaySelector(
//                           label: 'S',
//                           selected: selectedDays['S2']!,
//                           onTap: () => _toggleDay('S2'),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 18),

//                     Container(
//                       height: 1,
//                       color: Colors.white12,
//                       margin: EdgeInsets.symmetric(vertical: 12),
//                     ),

//                     // Choose hours label + bedtime & wakeup display
//                     Text(
//                       'Choose hours',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 16,
//                       ),
//                     ),
//                     SizedBox(height: 16),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _TimeDisplay(
//                           icon: Icons.nightlight_round,
//                           label: 'bedtime',
//                           time: bedtime,
//                           onTap: _pickBedtime,
//                         ),
//                         _TimeDisplay(
//                           icon: Icons.alarm,
//                           label: 'wake-up time',
//                           time: wakeupTime,
//                           onTap: _pickWakeupTime,
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: 32),

//                     // Circular clock showing bedtime and wake-up markers
//                     Expanded(
//                       child: Center(
//                         child: CustomPaint(
//                           size: Size(240, 240),
//                           painter: SleepGoalsClockPainter(
//                             bedtime: bedtime,
//                             wakeupTime: wakeupTime,
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: 12),

//                     Center(
//                       child: Text(
//                         '${totalSleepHours.toStringAsFixed(0)}h\nsleep goals',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                           height: 1.2,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),

//                     SizedBox(height: 48),

//                     // Bottom nav bar replica (optional, can be removed if back to home)
//                   ],
//                 ),
//               ),
//             ),

//             // Bottom navigation bar same as home
//             Container(
//               color: topBarColor,
//               padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(Icons.notifications_none_outlined, color: backgroundColor),
//                   Icon(Icons.home_outlined, color: backgroundColor),
//                   Icon(Icons.favorite_outline, color: Color(0xFFB76E6E)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _toggleDay(String dayKey) {
//     setState(() {
//       selectedDays[dayKey] = !(selectedDays[dayKey] ?? false);
//     });
//   }

//   Future<void> _pickBedtime() async {
//     final TimeOfDay? picked =
//         await showTimePicker(context: context, initialTime: bedtime);
//     if (picked != null && picked != bedtime) {
//       setState(() {
//         bedtime = picked;
//       });
//     }
//   }

//   Future<void> _pickWakeupTime() async {
//     final TimeOfDay? picked =
//         await showTimePicker(context: context, initialTime: wakeupTime);
//     if (picked != null && picked != wakeupTime) {
//       setState(() {
//         wakeupTime = picked;
//       });
//     }
//   }

//   double _calculateSleepHours() {
//     final int bedtimeMinutes = bedtime.hour * 60 + bedtime.minute;
//     final int wakeMinutes = wakeupTime.hour * 60 + wakeupTime.minute;

//     int diff = wakeMinutes - bedtimeMinutes;
//     if (diff <= 0) diff += 24 * 60;

//     return diff / 60;
//   }
// }

// // Single day circle selector in Sleep Goals page
// class _DaySelector extends StatelessWidget {
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;

//   const _DaySelector({
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bgColor = selected ? Colors.white : Colors.transparent;
//     final textColor = selected ? Colors.black : Colors.white70;

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 32,
//         height: 32,
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           label,
//           style: TextStyle(
//             color: textColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Time display column with icon, time label and tap handler for picking time
// class _TimeDisplay extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final TimeOfDay time;
//   final VoidCallback onTap;

//   const _TimeDisplay({
//     required this.icon,
//     required this.label,
//     required this.time,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final timeString =
//         time.hour.toString().padLeft(2, '0') + ':' + time.minute.toString().padLeft(2, '0');

//     return InkWell(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Icon(icon, color: Color(0xFFFFD8A9), size: 28),
//           SizedBox(width: 8),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 timeString,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 label,
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// // Custom painter for circular clock with bedtime and wake-up marks
// class SleepGoalsClockPainter extends CustomPainter {
//   final TimeOfDay bedtime;
//   final TimeOfDay wakeupTime;

//   SleepGoalsClockPainter({
//     required this.bedtime,
//     required this.wakeupTime,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = size.center(Offset.zero);
//     final radius = size.width / 2;

//     final paintBackground = Paint()
//       ..color = Colors.grey.shade700.withOpacity(0.3)
//       ..style = PaintingStyle.fill;

//     final paintCircle = Paint()
//       ..color = Color(0xFF16234B)
//       ..style = PaintingStyle.fill;

//     final paintBedtime = Paint()
//       ..color = Color(0xFFFFD8A9)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4;

//     final paintWakeup = Paint()
//       ..color = Color(0xFFFFD8A9)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4;

//     final paintHands = Paint()
//       ..color = Colors.white70
//       ..strokeWidth = 3
//       ..strokeCap = StrokeCap.round;

//     // Draw grey circle background for entire clock
//     canvas.drawCircle(center, radius, paintBackground);
//     // Inner navy blue circle
//     canvas.drawCircle(center, radius * 0.8, paintCircle);

//     // Draw bedtime and wakeup marks on circumference
//     final bedtimeAngle = _timeToRadians(bedtime);
//     final wakeupAngle = _timeToRadians(wakeupTime);

//     final rMark = radius * 0.82;

//     // Draw small marks
//     final bedtimeMarkStart = Offset(
//       center.dx + rMark * cos(bedtimeAngle),
//       center.dy + rMark * sin(bedtimeAngle),
//     );
//     final wakeupMarkStart = Offset(
//       center.dx + rMark * cos(wakeupAngle),
//       center.dy + rMark * sin(wakeupAngle),
//     );

//     // Mark length
//     const double markLength = 15;

//     final bedtimeMarkEnd = Offset(
//       center.dx + (rMark - markLength) * cos(bedtimeAngle),
//       center.dy + (rMark - markLength) * sin(bedtimeAngle),
//     );

//     final wakeupMarkEnd = Offset(
//       center.dx + (rMark - markLength) * cos(wakeupAngle),
//       center.dy + (rMark - markLength) * sin(wakeupAngle),
//     );

//     // Draw arcs or line segments representing bedtime and wakeup time
//     canvas.drawLine(bedtimeMarkStart, bedtimeMarkEnd, paintBedtime);
//     canvas.drawLine(wakeupMarkStart, wakeupMarkEnd, paintWakeup);

//     // Draw bed icon near bedtime mark
//     _drawIcon(
//       canvas,
//       center,
//       radius * 0.6,
//       bedtimeAngle,
//       Icons.nightlight_round,
//       Color(0xFFFFD8A9),
//     );

//     // Draw alarm icon near wakeup mark
//     _drawIcon(
//       canvas,
//       center,
//       radius * 0.6,
//       wakeupAngle,
//       Icons.alarm,
//       Color(0xFFFFD8A9),
//     );

//     // Draw clock hands showing current bedtime & wakeup clock times
//     // Bedtime hour hand
//     _drawHand(canvas, center, radius * 0.5, bedtimeAngle, paintHands, 5);
//     // Wakeup hour hand
//     _drawHand(canvas, center, radius * 0.5, wakeupAngle, paintHands, 5);

//     // Draw inner small dots for decoration
//     final dotPaint = Paint()..color = Colors.white.withOpacity(0.1);
//     for (int i = 0; i < 60; i++) {
//       final dotAngle = (i / 60) * 2 * 3.1415926535 - 3.1415926535 / 2;
//       final dotRadius = radius * 0.75;
//       final point = Offset(
//         center.dx + dotRadius * cos(dotAngle),
//         center.dy + dotRadius * sin(dotAngle),
//       );
//       canvas.drawCircle(point, 1, dotPaint);
//     }
//   }

//   double _timeToRadians(TimeOfDay time) {
//     // Convert time (hour & minute) to radians where 12 o'clock is at top
//     final double hourAngle = ((time.hour % 12) + time.minute / 60) / 12 * 2 * 3.1415926535;
//     return hourAngle - 3.1415926535 / 2; // rotate so 12 o'clock is top ( -90 degrees)
//   }

//   void _drawHand(Canvas canvas, Offset center, double length, double angle, Paint paint, double width) {
//     final end = Offset(center.dx + length * cos(angle), center.dy + length * sin(angle));
//     canvas.drawLine(center, end, paint..strokeWidth = width);
//   }

//   void _drawIcon(Canvas canvas, Offset center, double distance, double angle, IconData icon, Color color) {
//     final iconSize = 24.0;
//     final offset = Offset(center.dx + distance * cos(angle), center.dy + distance * sin(angle));

//     final pictureRecorder = PictureRecorder();
//     final canvasIcon = Canvas(pictureRecorder);
//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.text = TextSpan(
//       text: String.fromCharCode(icon.codePoint),
//       style: TextStyle(
//         fontSize: iconSize,
//         fontFamily: icon.fontFamily,
//         package: icon.fontPackage,
//         color: color,
//       ),
//     );
//     textPainter.layout();
//     textPainter.paint(canvas, offset - Offset(iconSize / 2, iconSize / 2));
//   }

//   @override
//   bool shouldRepaint(covariant SleepGoalsClockPainter oldDelegate) {
//     return oldDelegate.bedtime != bedtime || oldDelegate.wakeupTime != wakeupTime;
//   }
// }