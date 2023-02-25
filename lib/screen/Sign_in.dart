import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Custom_widget/Custom_Button.dart';
import 'package:flash_chat/Custom_widget/Custom_field.dart';
import 'package:flash_chat/screen/Chat_Screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController Controlleremail;
  late TextEditingController Controllerpassword;
  late String email;
  late String password;
  bool progresshow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Controlleremail = TextEditingController();
    Controllerpassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
        
          blur: 2.0,
          inAsyncCall: progresshow,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 140,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomField(
                  lbeltxt: 'Enter your Email',
                  hintxt: 'Enter your Email',
                  txtclr: Controlleremail,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomField(
                  lbeltxt: 'Password',
                  hintxt: 'Enter your password',
                  txtclr: Controllerpassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () async {
                      email = Controlleremail.text.toString();
                      password = Controllerpassword.text.toString();
                      setState(() {
                        progresshow = true;
                      });
                      try {
                        final login = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                        if (login != null) {
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatScreen()),
                          );
                        }
                        setState(() {
                          progresshow = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: CustomButton(color: Colors.blue, title: 'Sign In')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
