import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final folders = [
      {'name': 'likelion14th', 'count': '19'},
      {'name': 'Ideathon', 'count': '50'},
      {'name': 'likelion13th', 'count': '19'},
      {'name': 'kau_sw', 'count': '6'},
    ];

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text('폴더 혹은 닉네임을 입력해주세요.',
                        style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ),
                  Icon(Icons.search, color: Colors.grey, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  final folder = folders[index];
                  return Column(
                    children: [
                      Expanded(
                        child: Image.asset('assets/image/folder.png',
                            fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${folder['name']}(${folder['count']})',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFE75480),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}