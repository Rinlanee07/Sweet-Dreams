import 'package:flutter/material.dart';

void main() {
  runApp(const SleepApp());
}

class SleepApp extends StatelessWidget {
  const SleepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep Menu',
      debugShowCheckedModeBanner: false,
      home: const SleepMenuPage(),
    );
  }
}

class SleepMenuPage extends StatelessWidget {
  const SleepMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFF15294B); // Navy blue for menu background
    final peachColor = const Color(0xffffd89d); // bottom bar and icons bg

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top section with back arrow, cat image and page indicators
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xffeee1df),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  // Back Arrow
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.brown, size: 25),
                        onPressed: () {}, // Add back functionality if needed
                      ),
                    ],
                  ),
                  // Cat image centered
                  Image.asset(
                    'assets/2.png',
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(color: peachColor, size: 10),
                      const SizedBox(width: 8),
                      _buildDot(color: Colors.brown.shade400, size: 8),
                      const SizedBox(width: 8),
                      _buildDot(color: Colors.brown.shade400, size: 8),
                      const SizedBox(width: 8),
                      _buildDot(color: Colors.brown.shade400, size: 8),
                    ],
                  ),
                ],
              ),
            ),

            // Menu section
            Expanded(
              child: Container(
                width: double.infinity,
                color: backgroundColor,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'MENU',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: 'Caveat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 2x2 Grid of menu items
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _MenuItem(
                                imageAsset: 'assets/7.png',
                                title: 'Sleep Tracking',
                                bgColor: peachColor,
                                onTap: () {},
                              ),
                              _MenuItem(
                                imageAsset: 'assets/9.png',
                                title: 'Sleep Statistics',
                                bgColor: peachColor,
                                onTap: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _MenuItem(
                                imageAsset: 'assets/8.png',
                                title: 'Sleep Mood',
                                bgColor: peachColor,
                                onTap: () {},
                              ),
                              _MenuItem(
                                imageAsset: 'assets/10.png',
                                title: 'sleep Goals',
                                bgColor: peachColor,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar Mimic
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: peachColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none_rounded, size: 30, color: Colors.brown),
                    onPressed: () {},
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.brown, width: 1.6),
                    ),
                    child: const Icon(Icons.home_outlined, size: 32, color: Colors.brown),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_outline, size: 30, color: Colors.brown),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String imageAsset;
  final String title;
  final Color bgColor;
  final void Function()? onTap;

  const _MenuItem({
    required this.imageAsset,
    required this.title,
    required this.bgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(70),
            onTap: onTap,
            child: CircleAvatar(
              radius: 55,
              backgroundColor: bgColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(imageAsset, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'ComicSansMS',
            ),
          )
        ],
      ),
    );
  }
}