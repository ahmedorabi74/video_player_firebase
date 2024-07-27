import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD9A9A9),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.92,
                color: Colors.white, // Background color of the clipped area
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  const Center(
                    child: Text(
                      'FORGOT PASSWORD',
                      style: TextStyle(color: Colors.black, fontSize: 28),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "EMAIL",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.050,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD9A9A9),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 85, vertical: 15),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Request Link",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0350,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Color(0xff595959), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
