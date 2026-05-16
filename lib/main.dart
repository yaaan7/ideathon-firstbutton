import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/wallet_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '첫 단추',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentTab == 0 ? const HomeScreen() : const WalletScreen(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => setState(() => _currentTab = 0),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.home_outlined,
                      color: _currentTab == 0 ? const Color(0xFFE75480) : Colors.grey),
                  Text('홈',
                      style: TextStyle(
                          fontSize: 10,
                          color: _currentTab == 0 ? const Color(0xFFE75480) : Colors.grey)),
                ]),
              ),
              const SizedBox(width: 60),
              GestureDetector(
                onTap: () => setState(() => _currentTab = 1),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.folder_outlined,
                      color: _currentTab == 1 ? const Color(0xFFE75480) : Colors.grey),
                  Text('지갑',
                      style: TextStyle(
                          fontSize: 10,
                          color: _currentTab == 1 ? const Color(0xFFE75480) : Colors.grey)),
                ]),
              ),
            ],
          ),
          // 단추 버튼 위로 튀어나옴
          Positioned(
            top: -20,
            child: Container(
              width: 56, height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFF9D0E0),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/image/logo_image.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}