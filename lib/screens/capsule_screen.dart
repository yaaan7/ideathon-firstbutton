import 'package:flutter/material.dart';
import 'result_screen.dart';

class CapsuleScreen extends StatelessWidget {
  const CapsuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: Colors.grey),
        ),
        title: Image.asset('assets/image/logo.png', height: 24),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage('assets/image/dog.png'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 48),
          const Text(
            '두분의 연결을 성공했어요.',
            style: TextStyle(
                color: Color(0xFFE75480),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            '원하시는 캡슐을 선택해 주세요!',
            style: TextStyle(color: Colors.black87, fontSize: 14),
          ),
          const SizedBox(height: 52),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCapsule(context, const Color(0xFFF9A8D4), const Color(0xFFFDF2F8), '공통 관심사'),
              const SizedBox(width: 28),
              _buildCapsule(context, const Color(0xFF93C5FD), const Color(0xFFEFF6FF), '커리어'),
            ],
          ),
          const SizedBox(height: 28),
          _buildCapsule(context, const Color(0xFFFDE68A), const Color(0xFFFFFBEB), '취미'),
        ],
      ),
    );
  }

  Widget _buildCapsule(BuildContext context, Color topColor, Color bottomColor, String label) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ResultScreen(capsuleType: label)),
      ),
      child: SizedBox(
        width: 130, height: 130,
        child: ClipOval(
          child: Column(children: [
            Container(height: 65, color: topColor),
            Container(height: 65, color: bottomColor),
          ]),
        ),
      ),
    );
  }
}