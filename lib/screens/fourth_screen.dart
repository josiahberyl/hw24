import 'package:flutter/material.dart';
import 'package:newdemo/screens/home_screen.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Home Workout", style: TextStyle(color: Colors.black))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 100, color: Colors.red),
            SizedBox(height: 20),
            Text("Workout Complete!", style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Finish", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}
