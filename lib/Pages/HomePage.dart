import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: const Text("Video App Player",style: TextStyle(color: Colors.white),),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              await googleSignIn.signOut();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("LoginPage", (route) => false);
            },
            icon: const Icon(Icons.logout,color: Colors.white,),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 25),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'UploadVideo');
              },
              child: const Text(
                "Upload new video",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffD9A9A9),
                padding:
                    const EdgeInsets.symmetric(horizontal: 78, vertical: 25),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'TimeLine');
              },
              child: const Text(
                "Go to timeline",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
