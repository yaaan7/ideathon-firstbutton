import 'package:flutter/material.dart';
import 'capsule_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  int _step = 0; // 0=대기, 1=교환중, 2=상대카드구경
  bool _isFlipped = false;

  late AnimationController _myCardController;
  late Animation<Offset> _myCardAnim;

  late AnimationController _theirCardController;
  late Animation<Offset> _theirCardAnim;

  late AnimationController _flipController;
  late Animation<double> _flipAnim;

  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    _myCardController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _myCardAnim = Tween<Offset>(
        begin: Offset.zero, end: const Offset(0, -3))
        .animate(CurvedAnimation(
        parent: _myCardController, curve: Curves.easeIn));

    _theirCardController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _theirCardAnim = Tween<Offset>(
        begin: const Offset(0, -3), end: Offset.zero)
        .animate(CurvedAnimation(
        parent: _theirCardController, curve: Curves.easeOut));

    _flipController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _flipAnim = Tween<double>(begin: 0, end: 1).animate(_flipController);

    _progressController = AnimationController(
        vsync: this, duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _myCardController.dispose();
    _theirCardController.dispose();
    _flipController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _startExchange() async {
    if (_step != 0) return;
    setState(() => _step = 1);

    // 내 카드 위로 날아가기
    await _myCardController.forward();

    // 상대 카드 위에서 내려오기
    await _theirCardController.forward();

    setState(() => _step = 2);
    _progressController.forward();

    // 5초 후 캡슐 화면
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const CapsuleScreen(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    }
  }

  void _flipCard() {
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 상대방 카드 (위에서 내려옴)
                  if (_step >= 1)
                    SlideTransition(
                      position: _theirCardAnim,
                      child: GestureDetector(
                        onTap: _step == 2 ? _flipCard : null,
                        child: AnimatedBuilder(
                          animation: _flipAnim,
                          builder: (_, __) {
                            final angle = _flipAnim.value * 3.14159;
                            final isFront = _flipAnim.value < 0.5;
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(angle),
                              child: isFront
                                  ? _buildTheirCardFront()
                                  : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateY(3.14159),
                                child: _buildTheirCardBack(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  // 내 카드 (위로 날아감)
                  if (_step <= 1)
                    SlideTransition(
                      position: _myCardAnim,
                      child: _buildMyCard(),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            if (_step == 0) ...[
              // 교환 버튼
              GestureDetector(
                onTap: _startExchange,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE75480),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.pink.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wifi_tethering, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text('명함 교환하기',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('버튼을 누르면 상대방에게 명함이 전송돼요',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ] else if (_step == 2) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: AnimatedBuilder(
                  animation: _progressController,
                  builder: (_, __) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _progressController.value,
                      minHeight: 6,
                      backgroundColor: const Color(0xFFFBCFE8),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFE75480)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text('로딩중...',
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 8),
              const Text(
                '우리 함께\n첫 단추를 꿰매보아요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFE75480),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.5),
              ),
              const SizedBox(height: 8),
              const Text('탭하면 상대방 명함 뒤집기',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMyCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/image/card_front.png',
        width: 240,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTheirCardFront() {
    return Container(
      width: 240,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Text('박민준',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: const Color(0xFF60A5FA),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('상대방',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ]),
            const SizedBox(height: 4),
            const Text('Product Manager',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
            const Text('핀테크 스타트업',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
            const SizedBox(height: 8),
            const Text('탭해서 키워드 보기 👆',
                style: TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildTheirCardBack() {
    return Container(
      width: 240,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('키워드',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB))),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: ['전략기획', '데이터', '스쿼시', '맥주', 'INTJ']
                  .map((k) => Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(k,
                    style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF2563EB))),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}