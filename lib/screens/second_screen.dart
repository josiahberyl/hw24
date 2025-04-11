import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final List<Map<String, String>> workouts = [
    {
      'name': 'Football Drills',
      'image':
          'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg'
    },
    {
      'name': 'Pull-ups',
      'image':
          'https://images.pexels.com/photos/1552249/pexels-photo-1552249.jpeg'
    },
    {
      'name': 'Push-ups',
      'image':
          'https://images.pexels.com/photos/416778/pexels-photo-416778.jpeg'
    },
    {
      'name': 'Squats',
      'image':
          'https://images.pexels.com/photos/414029/pexels-photo-414029.jpeg'
    },
    {
      'name': 'V-Sit',
      'image':
          'https://images.pexels.com/photos/841130/pexels-photo-841130.jpeg'
    },
    {
      'name': 'Wall Sit',
      'image':
          'https://images.pexels.com/photos/3822292/pexels-photo-3822292.jpeg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Workout List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: workouts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final workout = workouts[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.redAccent, width: 1),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      workout['image']!,
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(child: CircularProgressIndicator(color: Colors.red));
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    workout['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: LinearProgressIndicator(
                      value: 0.5, // You can customize this value
                      color: Colors.redAccent,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms, delay: (100 * index).ms);
          },
        ),
      ),
    );
  }
}
