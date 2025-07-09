import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk leaderboard
    final List<Map<String, dynamic>> leaderboard = [
      {'rank': 1, 'name': 'Ronaldo', 'goals': 20, 'color': Colors.yellow},
      {'rank': 2, 'name': 'Eto', 'goals': 14, 'color': Colors.grey.shade300},
      {'rank': 3, 'name': 'Mila', 'goals': 7, 'color': Colors.orange},
      {'rank': 4, 'name': 'Eto', 'goals': 5},
      {'rank': 5, 'name': 'Eto', 'goals': 4},
      {'rank': 6, 'name': 'Eto', 'goals': 3},
      {'rank': 7, 'name': 'Eto', 'goals': 2},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(500, 248, 55, 88),
        elevation: 0,
        title: const Text(
          'Leaderboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Background merah
          Container(
            color: const Color.fromARGB(500, 248, 55, 88),
          ),
          // Konten utama
          Column(
            children: [
              const SizedBox(height: 100),
              // Daftar pemain
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: leaderboard.length,
                    itemBuilder: (context, index) {
                      final player = leaderboard[index];
                      final bool isTop3 = index < 3; // Cek apakah pemain termasuk top 3
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isTop3
                              ? player['color'] ?? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Nomor urutan
                            Text(
                              '${player['rank']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: isTop3 ? Colors.black : Colors.pink,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Avatar
                            CircleAvatar(
                              backgroundColor: isTop3
                                  ? Colors.pink.shade900
                                  : Colors.pink.shade400,
                              child: const Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            // Nama dan jumlah goals
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${player['name']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isTop3 ? Colors.black : Colors.pink,
                                    ),
                                  ),
                                  Text(
                                    '${player['goals']} goals',
                                    style: const TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
