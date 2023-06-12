import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_text_filed.dart';
import 'package:dpc_flutter/components/Pwd_text_filed.dart';

class SignUp extends StatelessWidget {
  final userNameController = TextEditingController();
  final pwdController = TextEditingController();
  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Image.asset('lib/images/mobile_login_amico.png'),
            My_text_filed(
                controller: userNameController,
                hintText: 'First Name',
                obsecureText: true,
                icon: Icons.person),
            const SizedBox(height: 10),
            PasswordTextField()
          ],
        )),
      ),
    );
  }
}
