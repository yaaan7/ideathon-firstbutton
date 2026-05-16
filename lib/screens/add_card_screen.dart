import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  int _step = 0; // 0=방식선택, 1=꾸미기, 2=키워드

  final List<String> _keywords = ['멋쟁이사자처럼', '프론트엔드', '기획', '디자인'];
  final TextEditingController _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  void _nextStep() => setState(() => _step++);
  void _prevStep() {
    if (_step == 0) {
      Navigator.pop(context);
    } else {
      setState(() => _step--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: GestureDetector(
          onTap: _prevStep,
          child: const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 18),
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
          // 스텝 인디케이터
          _buildStepIndicator(),
          Expanded(
            child: _step == 0
                ? _buildStep1()
                : _step == 1
                ? _buildStep2()
                : _buildStep3(),
          ),
          // 하단 버튼
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
        children: List.generate(3, (i) {
          final isActive = i <= _step;
          final isCurrent = i == _step;
          return Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? const Color(0xFFE75480)
                            : isActive
                            ? const Color(0xFFFBCFE8)
                            : const Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text('${i + 1}',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isCurrent
                                    ? Colors.white
                                    : isActive
                                    ? const Color(0xFFE75480)
                                    : Colors.grey)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${i + 1}단계',
                        style: TextStyle(
                            fontSize: 10,
                            color: isCurrent
                                ? const Color(0xFFE75480)
                                : Colors.grey)),
                  ],
                ),
                if (i < 2)
                  Expanded(
                    child: Container(
                      height: 1,
                      margin: const EdgeInsets.only(bottom: 16),
                      color: isActive
                          ? const Color(0xFFFBCFE8)
                          : const Color(0xFFF3F4F6),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // 1단계: 방식 선택
  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('명함 만들기',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('어떤 방식으로 시작할까요?',
              style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 32),
          _buildOptionCard(
            icon: Icons.edit_outlined,
            title: '직접 만들래요',
            desc: '스티커, 손그림, 텍스트로\n자유롭게 꾸며요!',
            onTap: _nextStep,
          ),
          const SizedBox(height: 16),
          _buildOptionCard(
            icon: Icons.auto_awesome_outlined,
            title: 'AI로 만들래요',
            desc: '프롬프트를 입력하면\n명함을 빠르게 만들어줘요!',
            onTap: _nextStep,
            disabled: true,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String desc,
    required VoidCallback onTap,
    bool disabled = false,
  }) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: disabled ? const Color(0xFFF9FAFB) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: disabled
                  ? const Color(0xFFF3F4F6)
                  : const Color(0xFFFBCFE8)),
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: disabled
                    ? const Color(0xFFF3F4F6)
                    : const Color(0xFFFDF2F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  color: disabled ? Colors.grey : const Color(0xFFE75480),
                  size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: disabled ? Colors.grey : const Color(0xFF1F2937))),
                  const SizedBox(height: 4),
                  Text(desc,
                      style: const TextStyle(fontSize: 12, color: Colors.grey, height: 1.4)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 14, color: disabled ? Colors.grey[300] : Colors.grey),
          ],
        ),
      ),
    );
  }

  // 2단계: 꾸미기
  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('명함 꾸미기',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE75480),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('가로', style: TextStyle(color: Colors.white, fontSize: 11)),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('세로', style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text('스티커를 붙이거나, 손그림과 텍스트로 자유롭게 꾸며보세요!',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),

          // 캔버스
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF3F4F6)),
              ),
              child: const Center(
                child: Text('명함 꾸미기 영역\n(추후 구현)',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 툴바
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTool(Icons.wallpaper_outlined, '배경', true),
              _buildTool(Icons.sentiment_satisfied_alt_outlined, '스티커', false),
              _buildTool(Icons.edit_outlined, '펜', false),
              _buildTool(Icons.text_fields_outlined, '텍스트', false),
              _buildTool(Icons.image_outlined, '사진', false),
            ],
          ),
          const SizedBox(height: 12),

          // 색상 선택
          Row(
            children: [
              const Icon(Icons.undo, color: Colors.grey, size: 20),
              const SizedBox(width: 8),
              const Icon(Icons.redo, color: Colors.grey, size: 20),
              const SizedBox(width: 12),
              ...[ Colors.white, const Color(0xFFE75480), const Color(0xFFFBBF24),
                const Color(0xFFF9F9F9), const Color(0xFF818CF8), const Color(0xFF60A5FA)
              ].map((c) => GestureDetector(
                onTap: () {},
                child: Container(
                  width: 24, height: 24,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFF3F4F6)),
                  ),
                ),
              )),
              const Icon(Icons.add_circle_outline, color: Colors.grey, size: 22),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTool(IconData icon, String label, bool isSelected) {
    return Column(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE75480) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon,
              color: isSelected ? Colors.white : Colors.grey, size: 22),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 10,
                color: isSelected ? const Color(0xFFE75480) : Colors.grey)),
      ],
    );
  }

  // 3단계: 키워드
  Widget _buildStep3() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('키워드 작성하기',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('요즘 관심사, 취미 등등 키워드로 나를 표현해요!',
              style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 24),

          // 입력
          TextField(
            controller: _keywordController,
            decoration: InputDecoration(
              hintText: '키워드를 입력해주세요',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  if (_keywordController.text.isNotEmpty) {
                    setState(() {
                      _keywords.add(_keywordController.text);
                      _keywordController.clear();
                    });
                  }
                },
                child: const Icon(Icons.add, color: Color(0xFFE75480)),
              ),
            ),
            onSubmitted: (val) {
              if (val.isNotEmpty) {
                setState(() {
                  _keywords.add(val);
                  _keywordController.clear();
                });
              }
            },
          ),
          const SizedBox(height: 20),

          // 키워드 태그
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _keywords.map((k) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF2F8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFBCFE8)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(k,
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFFE75480))),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => setState(() => _keywords.remove(k)),
                    child: const Icon(Icons.close,
                        size: 14, color: Color(0xFFE75480)),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: GestureDetector(
        onTap: () {
          if (_step < 2) {
            _nextStep();
          } else {
            Navigator.pop(context);
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFE75480),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              _step == 2 ? '명함 만들기' : '다음',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}