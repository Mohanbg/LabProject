import 'package:flutter/material.dart';
import 'package:flutter_application_1/repo/user_repo.dart';
import 'package:flutter_application_1/views/login_page.dart';
import 'package:flutter_application_1/widgets/custom_widgets.dart';

class HomePage extends StatefulWidget {
  final String? emailId;

  HomePage({super.key, required this.emailId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserRepository? _userRepository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            lottie(context),
            const Text(
              "WELCOME",
              style: TextStyle(fontSize: 30.0),
            ),
            const SizedBox(height: 10),
            Text(widget.emailId.toString()),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  _userRepository?.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text("Logout"))
          ],
        ),
      )),
    );
  }
}
