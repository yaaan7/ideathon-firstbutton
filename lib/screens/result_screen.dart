import 'package:flutter/material.dart';
import '../main.dart';

class ResultScreen extends StatelessWidget {
  final String capsuleType;
  const ResultScreen({super.key, required this.capsuleType});

  @override
  Widget build(BuildContext context) {
    final questions = _getDummyQuestions(capsuleType);
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text('AI가 찾은 연결고리 ✨',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('$capsuleType 기반 대화 질문이에요',
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 24),
            ...questions.map((q) =>
                _buildQuestionCard(q['emoji']!, q['text']!, q['why']!)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(String emoji, String text, String why) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.pink.withOpacity(0.06), blurRadius: 10),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
                color: const Color(0xFFFDF2F8),
                borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text('💡 $why',
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getDummyQuestions(String type) {
    switch (type) {
      case '커리어':
        return [
          {'emoji': '💼', 'text': 'PM으로 일하면서 가장 재밌는 순간이 언제예요?', 'why': '커리어 공통 관심사'},
          {'emoji': '🚀', 'text': '사이드프로젝트 하고 계신 거 있으세요?', 'why': '사이드프로젝트 연결'},
          {'emoji': '📊', 'text': '데이터 분석 어떤 툴 주로 쓰세요?', 'why': '개발-PM 협업 포인트'},
        ];
      case '취미':
        return [
          {'emoji': '🍺', 'text': '홈브루잉 어떻게 시작하게 됐어요?', 'why': '취미 탐색'},
          {'emoji': '🏃', 'text': '새벽 러닝이랑 홈트 중에 뭐가 더 힘들어요?', 'why': '운동 공통점'},
          {'emoji': '📚', 'text': '요즘 독립서점에서 산 책 있어요?', 'why': '독서 취향 연결'},
        ];
      default:
        return [
          {'emoji': '☕', 'text': '사이드프로젝트 얘기 더 해줄 수 있어요?', 'why': '공통 사이드프로젝트'},
          {'emoji': '🐱', 'text': '고양이 키우세요? 저도 집사인데!', 'why': '고양이 공통 관심사'},
          {'emoji': '📖', 'text': '독서 클럽은 어떤 책 읽어요?', 'why': '독립서점 탐방 연결'},
        ];
    }
  }
}