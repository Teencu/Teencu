import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ProfilePage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(500, 248, 55, 88),
        elevation: 0,
        title: Text(
          'Account',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Background warna pink
          Container(
            color: Color.fromARGB(500, 248, 55, 88),
          ),
          // Konten utama
          Column(
            children: [
              SizedBox(height: 30),
              // Avatar dan nama
              CircleAvatar(
                radius: 50, // Ukuran avatar
                backgroundImage: AssetImage("assets/icons/profile_avatar.png"),
              ),
              SizedBox(height: 12),
              Text(
                'ENFP #001',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              // Kontainer putih untuk detail profil
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email
                      _buildProfileDetail(
                        label: 'EMAIL ADDRESS',
                        value: user?.email ?? 'Unknown',
                      ),
                      SizedBox(height: 24),
                      // Points
                      FutureBuilder<int?>(
                        future: getPoints(user?.uid ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          int? userPoints = snapshot.data;
                          return _buildProfileDetail(
                            label: 'POINTS',
                            value: userPoints?.toString() ?? '0',
                          );
                        },
                      ),
                      FutureBuilder<String?>(
                        future: getLastMbti(user?.uid ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          String? userMbti = snapshot.data;
                          return _buildProfileDetail(
                            label: 'YOUR LAST MBTI',
                            value: userMbti ?? '-',
                          );
                        },
                      ),
                      FutureBuilder<DateTime?>(
                        future: getLastMbtiDate(user?.uid ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          DateTime? userMbtiDate = snapshot.data;
                          String tanggal = DateFormat('yyyy-MM-dd - kk:mm').format(userMbtiDate!) ?? '-';
                          return _buildProfileDetail(
                            label: 'YOUR LAST MBTI TEST',
                            value: tanggal,
                          );
                        },
                      ),
                      Spacer(),
                      // Tombol Logout
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Logika logout
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(500, 248, 55, 88),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk detail profil
  Widget _buildProfileDetail(
      {required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // Fungsi untuk mengambil nilai points dari Firestore
  Future<int?> getPoints(String docId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .get();

      if (doc.exists && doc.data() != null) {
        return doc.get('points') as int;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getLastMbti(String docId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .get();

      if (doc.exists && doc.data() != null) {
        return doc.get('lastMbti') as String;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  Future<DateTime?> getLastMbtiDate(String docId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .get();

      if (doc.exists && doc.data() != null) {
        return doc.get('lastMbtiDate') as DateTime;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
