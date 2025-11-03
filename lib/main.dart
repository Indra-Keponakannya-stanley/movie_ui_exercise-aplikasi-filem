import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie UI Exercise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MovieHomePage(),
    );
  }
}

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({super.key});

  // daftar gambar lokal untuk carousel dan list
  final List<String> bigPosters = const [
    'assets/images/demon.jpg',
    'assets/images/naruto.jpg',
    'assets/images/tokyogol.jpg',
  ];

  final List<String> smallPosters = const [
    'assets/images/demon.jpg',
    'assets/images/attacktitan.jpg',
    'assets/images/naruto.jpg',
    'assets/images/bbokunohero.jpg',
    'assets/images/dadadan.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Now Playing',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            // === Carousel ===
            CarouselSlider.builder(
              itemCount: bigPosters.length,
              itemBuilder: (context, index, realIdx) {
                final path = bigPosters[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(path, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                height: 350,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
            ),
            const SizedBox(height: 16),

            // === Section Trending ===
            buildSection('Trending', smallPosters),

            // === Section Popular ===
            buildSection('Popular', smallPosters.reversed.toList()),

            // === Section Top Rated ===
            buildSection('Top Rated', smallPosters),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Fungsi reusable buat bikin section list horizontal
 Widget buildSection(String title, List<String> posters) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul section
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Daftar poster horizontal
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: posters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, idx) {
              final path = posters[idx];
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Image.asset(path, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
}