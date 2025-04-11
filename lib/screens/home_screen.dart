import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import 'third_screen.dart';
import 'second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TextEditingController textController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void addTask(String task) {
    if (task.isNotEmpty) {
      FirebaseFirestore.instance.collection('tasks').add({
        'task': task,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    textController.clear();
  }

  void deleteTask(String docId) {
    FirebaseFirestore.instance.collection('tasks').doc(docId).delete();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Workout', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          backgroundColor: Colors.red,
          actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout_rounded, color: Colors.black))],
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Today's workout",
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => addTask(textController.text),
                    child: Text("Add", style: TextStyle(color: Colors.black)),
                  )
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('tasks').orderBy('timestamp', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Center(child: CircularProgressIndicator(color: Colors.red));
                    final tasks = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        var task = tasks[index];
                        return ListTile(
                          title: Text(task['task'], style: TextStyle(color: Colors.white)),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteTask(task.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ThirdScreen())),
                icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
                label: Text("Proceed", style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SecondScreen())),
                child: Text("See other workouts", style: TextStyle(color: Colors.redAccent)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
