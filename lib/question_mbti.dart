import 'package:flutter/material.dart';
import 'package:teencu/result_mbti.dart';

class QuestionMbti extends StatefulWidget {
  @override
  _QuestionMbtiState createState() => _QuestionMbtiState();
}

class _QuestionMbtiState extends State<QuestionMbti> {
  int? selectedRating; // Variabel untuk menyimpan nilai rating pengguna
  final List<String> questions = [
    "Saya merasa lebih berenergi saat berada di acara sosial atau bersama banyak orang.",
    "Saya lebih suka menghabiskan waktu sendiri untuk menyegarkan pikiran.",
    "Saya suka berbicara untuk memecahkan masalah daripada merenungkannya dalam pikiran.",
    "Saya cenderung berbicara lebih banyak daripada mendengarkan dalam percakapan.",
    "Saya merasa nyaman bekerja dalam kelompok besar."
  ];

  int currentQuestionIndex = 0; // Pertanyaan yang ditampilkan saat ini
  Map<int, int> answers = {}; // Menyimpan jawaban untuk setiap pertanyaan

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        title: Text(
          'Pertanyaan MBTI',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              // Logo Teencu di tengah
              Center(
                child: Image.asset(
                  "assets/teencu_logo.png",
                  height: 80,
                ),
              ),
              // Progress bar
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / questions.length,
                backgroundColor: Colors.grey.shade300,
                color: Colors.pink,
              ),
              const SizedBox(height: 20),

              // Pertanyaan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  questions[currentQuestionIndex],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Pilihan Jawaban (Tombol)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: List.generate(5, (index) {
                      final ratings = [
                        "Sangat Tidak Setuju",
                        "Tidak Setuju",
                        "Netral",
                        "Setuju",
                        "Sangat Setuju"
                      ];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: double.infinity, // Tombol melebar sesuai layar
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: answers[currentQuestionIndex] ==
                                  index + 1
                                  ? Colors.pink
                                  : Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12), // Tinggi tombol seragam
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: Colors.pink,
                                  width: 2,
                                ),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                answers[currentQuestionIndex] = index + 1;
                              });
                            },
                            child: Text(
                              ratings[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: answers[currentQuestionIndex] ==
                                    index + 1
                                    ? Colors.white
                                    : Colors.pink,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Navigasi di bagian bawah
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: currentQuestionIndex > 0
                          ? () {
                        setState(() {
                          // Kembali ke pertanyaan sebelumnya
                          currentQuestionIndex--;
                          selectedRating = null;
                        });
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: currentQuestionIndex > 0
                            ? Colors.pink
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Sebelumnya",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: answers[currentQuestionIndex] != null
                          ? () {
                        if (currentQuestionIndex ==
                            questions.length - 1) {
                          // Semua pertanyaan dijawab, arahkan ke halaman hasil
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultMbti(
                                mbtiType: "ENFP", // Contoh hasil MBTI
                                name: "ENFP (The Inspirer)", // Ganti dengan nama pengguna
                                description:
                                "Kamu adalah seorang jack of all trades atau multi-talented. Dengan ketertarikan pada banyak hal,"
                                    " kamu memiliki berbagai bakat dan keterampilan, sering terlibat dalam banyak kegiatan sekaligus."
                                    " Hal ini membuatmu disukai banyak orang, meski kamu juga sensitif terhadap penilaian buruk."
                                    " Ketertarikanmu yang luas sering membuatmu cepat bosan, namun kamu tetap konsisten pada nilai yang kamu pegang."
                                    " Hangat, antusias, imajinatif, fleksibel, dan berani mengambil risiko, kamu mampu menginspirasi banyak orang.",
                                compatibleTypes: [
                                  "INFJ",
                                  "ENTP",
                                  "ENFP"
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Pindah ke pertanyaan berikutnya
                          setState(() {
                            currentQuestionIndex++;
                            selectedRating = null;
                          });
                        }
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: answers[currentQuestionIndex] != null
                            ? Colors.pink
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        currentQuestionIndex < questions.length - 1
                            ? "Selanjutnya"
                            : "Selesai",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
