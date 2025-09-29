import 'package:flutter/material.dart';
import 'page3.dart';

void main() {
  runApp(const SweetDreamsApp2());
}

class SweetDreamsApp2 extends StatelessWidget {
  const SweetDreamsApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SweetDreamsSecondPage(),
    );
  }
}

class SweetDreamsSecondPage extends StatefulWidget {
  const SweetDreamsSecondPage({super.key});

  @override
  State<SweetDreamsSecondPage> createState() => _SweetDreamsSecondPageState();
}

class _SweetDreamsSecondPageState extends State<SweetDreamsSecondPage> {
  static const navyBlue = Color(0xFF15294B);
  static const softOrange = Color(0xFFF9D6AB);
  static const lightPinkBg = Color(0xFFF2E6E1);
  static const textBrown = Color(0xFF4D3B2B);
  static const orangeButton = Color(0xFFFFA541);
  static const lightText = Color(0xFFFFF0E7);

  final List<String> petImages = [
    'https://cdn-icons-png.flaticon.com/512/616/616408.png', // Hamster
    'https://cdn-icons-png.flaticon.com/512/616/616408.png', // For example placeholder; replace by actual URLs below
    'https://cdn-icons-png.flaticon.com/512/616/616408.png',
  ];

  // Actually we have 4 pet images (Hamster, Lion, Cow, Cat main)
  final List<String> petThumbnails = [
    'https://cdn-icons-png.flaticon.com/512/616/616408.png', // hamster
    'https://cdn-icons-png.flaticon.com/512/616/616408.png', // lion replace with actual
    'https://cdn-icons-png.flaticon.com/512/616/616408.png', // cow replace with actual
  ];

  // Since you asked for that exact image: use your local assets or URLs
  // but to make example workable, use placeholder images that look correct
  // For demonstration, I will include illustrative URLs for pets below:
  // Cat (main)
  static const catImage =
      'https://cdn-icons-png.flaticon.com/512/616/616408.png';
  // Hamster
  static const hamsterImage =
      'https://cdn-icons-png.flaticon.com/512/616/616408.png';
  // Lion
  static const lionImage =
      'https://cdn-icons-png.flaticon.com/512/616/616408.png';
  // Cow
  static const cowImage =
      'https://cdn-icons-png.flaticon.com/512/616/616408.png';

  final List<String> petImagesList = [
    hamsterImage,
    lionImage,
    cowImage,
  ];

  int selectedIndex = 1; // The main cat image index = 1 (shown larger)
  // Actually, in UI cat is big image at top, below are hamster/lion/cow thumbnails,
  // but cat is not selectable below so we treat cat differently.
  // So selected pet among the three thumbnails below.

  int thumbnailSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBlue,
      body: Column(
        children: [
          // Curved top bar with text "Choose your pet"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: const BoxDecoration(
              color: softOrange,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            child: Text(
              'Choose your pet',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textBrown,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8,
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Large main pet image container with rounded corners and light pink bg
          Center(
            child: Container(
              width: 280,
              height: 180,
              decoration: BoxDecoration(
                color: lightPinkBg,
                borderRadius: BorderRadius.circular(22),
              ),
              alignment: Alignment.center,
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/616/616408.png',
                // This is the cat image from question's 2nd page top main pet,
                // change this URL to an actual cat image URL you want to show.
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 44),

          // Row with left arrow, 3 small pet icons, right arrow
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left arrow button
                IconButton(
                  icon: const Icon(Icons.arrow_left),
                  color: softOrange,
                  iconSize: 32,
                  onPressed: () {
                    setState(() {
                      if (thumbnailSelectedIndex > 0) {
                        thumbnailSelectedIndex--;
                      }
                    });
                  },
                ),

                const SizedBox(width: 8),

                // Pet thumbnails, clickable
                for (int i = 0; i < petImagesList.length; i++) ...[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        thumbnailSelectedIndex = i;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: thumbnailSelectedIndex == i
                            ? softOrange
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.network(
                        petImagesList[i],
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],

                const SizedBox(width: 8),

                // Right arrow button
                IconButton(
                  icon: const Icon(Icons.arrow_right),
                  color: softOrange,
                  iconSize: 32,
                  onPressed: () {
                    setState(() {
                      if (thumbnailSelectedIndex < petImagesList.length - 1) {
                        thumbnailSelectedIndex++;
                      }
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Confirm button in light pink bg color with rounded corners and brown text
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SleepMenuPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: lightPinkBg,
              fixedSize: const Size(160, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: Text(
              'confirm',
              style: TextStyle(
                color: textBrown,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Spacer to push bottom nav bar to bottom
          const Spacer(),

          // Bottom navigation bar (custom drawn)
          Container(
            height: 72,
            decoration: const BoxDecoration(
              color: softOrange,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bell icon with red notification dot top-right
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      size: 32,
                      color: textBrown,
                    ),
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: softOrange, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),

                // Home icon
                Icon(
                  Icons.home_outlined,
                  size: 32,
                  color: textBrown,
                ),

                // Heart icon with partially overlaid rounded container shape
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    // Background circle overlapping top of nav bar
                    Positioned(
                      top: -36,
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: softOrange,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36),
                          ),
                        ),
                      ),
                    ),
                    // Heart icon centered on top circle
                    Container(
                      width: 72,
                      height: 72,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.favorite,
                        size: 36,
                        color: textBrown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}