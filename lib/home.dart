import 'package:flutter/material.dart';
import 'package:teencu/expl_mbti.dart';
import 'package:teencu/leaderboard.dart';
import 'package:teencu/menu_chat.dart';
import 'package:teencu/profile_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // Menghapus ikon default di kiri
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 40), // Placeholder kosong untuk simetri
              Image.asset(
                "assets/teencu_logo.png", // Logo Teencu di tengah
                height: 100,
              ),
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman ProfilePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      AssetImage("assets/icons/profile_avatar.png"),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Image.asset(
              "assets/lightbulb.png",
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              "Apa yang Ingin kamu lakukan ?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // Tombol Tes MBTI
            _buildButton(context, "Tes MBTI", Color.fromARGB(500, 248,55,88), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MbtiExplanationPage()),
                );
              },),
            SizedBox(height: 16),
            // Tombol Chat
            _buildButton(context, "Chat", Color.fromARGB(500, 248,55,88), () {
              // Navigasi ke halaman Chat
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuChat()),
              );
            }),
            SizedBox(height: 16),
            // Tombol Leaderboard
            _buildButton(context, "Leaderboard", Color.fromARGB(500, 248,55,88), () {
              // Navigasi ke halaman Leaderboard
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Leaderboard()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
