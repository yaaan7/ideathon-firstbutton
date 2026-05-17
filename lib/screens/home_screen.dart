import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'add_card_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('현재 내 명함',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddCardScreen()),
                  ),
                  child: Text('새로운 명함 추가하기',
                      style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 명함 카드
            const _FlipCard(),
            const SizedBox(height: 6),
            const Center(
              child: Text('탭하면 키워드 보기 · 꾹 누르면 공유',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ),
            const SizedBox(height: 20),

            // 통계
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF3F4F6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(Icons.people_outline, const Color(0xFFFBCFE8), '모든 명함 수', '100 명'),
                  Container(width: 1, height: 40, color: const Color(0xFFF3F4F6)),
                  _buildStat(Icons.swap_horiz, const Color(0xFFFFE4CC), '교환 횟수', '88 회'),
                  Container(width: 1, height: 40, color: const Color(0xFFF3F4F6)),
                  _buildStat(Icons.emoji_events_outlined, const Color(0xFFE8E0FF), '랭킹', '3 위'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 오늘의 질문
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF3F4F6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('오늘의 질문 추천',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE75480))),
                      Text('더보기 >', style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildQuestion('우울할 때 어떤 걸로 위로를 받아?'),
                  _buildQuestion('좋아하는 영화 장르가 뭐야?'),
                  _buildQuestion('사주나 운세 보는 거 좋아해?'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text('명함 공유하기',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoadingScreen(),
                    transitionsBuilder: (_, anim, __, child) =>
                        SlideTransition(
                          position: Tween<Offset>(
                              begin: const Offset(0, 1), end: Offset.zero)
                              .animate(anim),
                          child: child,
                        ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE75480),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_tethering, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('NFC로 교환하기',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFBCFE8)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.link, color: Color(0xFFE75480), size: 20),
                  SizedBox(width: 8),
                  Text('링크로 공유하기',
                      style: TextStyle(
                          color: Color(0xFFE75480),
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildMyCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
              color: Colors.pink.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 앞면
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Text('얀',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8C42),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('멋사 14기',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ]),
                      const SizedBox(height: 4),
                      const Text('백엔드 개발자',
                          style: TextStyle(fontSize: 13, color: Colors.grey)),
                      const Text('한국항공대학교 소프트웨어학과 24학번',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
                Image.asset('assets/image/dog.png', width: 60),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFF3F4F6)),
            const SizedBox(height: 14),

            // 키워드
            const Text('키워드',
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _buildKeyword('INFP', const Color(0xFFE8E0FF), const Color(0xFF7C3AED)),
                _buildKeyword('가나디', const Color(0xFFFDF2F8), const Color(0xFFE75480)),
                _buildKeyword('백엔드 개발', const Color(0xFFEFF6FF), const Color(0xFF2563EB)),
                _buildKeyword('이자반 팬', const Color(0xFFFFF7ED), const Color(0xFFEA580C)),
                _buildKeyword('Java', const Color(0xFFEFF6FF), const Color(0xFF2563EB)),
                _buildKeyword('새벽 코딩', const Color(0xFFFDF2F8), const Color(0xFFE75480)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyword(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(fontSize: 11, color: textColor, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildStat(IconData icon, Color iconBg, String label, String value) {
    return Column(children: [
      Container(
        width: 44, height: 44,
        decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      const SizedBox(height: 2),
      Text(value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _buildQuestion(String text) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(children: [
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ]),
      ),
      const Divider(height: 1, color: Color(0xFFF3F4F6)),
    ]);
  }
}

void _showKeywords(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text('얀의 키워드',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              'INFP', '가나디', '백엔드 개발', 'Java',
              '새벽 코딩', '멋사 14기', '요즘 이자반 봄'
            ].map((k) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF2F8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFBCFE8)),
              ),
              child: Text(k,
                  style: const TextStyle(
                      fontSize: 13, color: Color(0xFFE75480))),
            )).toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// home_screen.dart 맨 아래에 추가
class _FlipCard extends StatefulWidget {
  const _FlipCard();
  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _anim = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      onLongPress: () => _showShareBottomSheet(context),
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          final angle = _anim.value * 3.14159;
          final isFront = _anim.value < 0.5;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: isFront
                ? _buildFront()
                : Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(3.14159),
              child: _buildBack(),
            ),
          );
        },
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 20),
            const Text('명함 공유하기',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoadingScreen(),
                    transitionsBuilder: (_, anim, __, child) =>
                        SlideTransition(
                          position: Tween<Offset>(
                              begin: const Offset(0, 1),
                              end: Offset.zero)
                              .animate(anim),
                          child: child,
                        ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE75480),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_tethering, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('NFC로 교환하기',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFBCFE8)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.link, color: Color(0xFFE75480), size: 20),
                  SizedBox(width: 8),
                  Text('링크로 공유하기',
                      style: TextStyle(
                          color: Color(0xFFE75480),
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildFront() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/image/card_front.png',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBack() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/image/card_back.png',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}