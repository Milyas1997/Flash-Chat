import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screen/Chat_Screen.dart';
import 'package:flutter/material.dart';

import '../Custom_widget/Custom_Button.dart';
import '../Custom_widget/Custom_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController Controlleremail;
  late TextEditingController Contrllerpassword;
  late String email;
  late String password;
  bool Pshow = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Controlleremail = TextEditingController();
    Contrllerpassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlurryModalProgressHUD(
          inAsyncCall: Pshow,
          blurEffectIntensity: 4,
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
                  txtclr: Contrllerpassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () async {
                      setState(() {
                        Pshow = true;
                      });
                      email = Controlleremail.text.toString();
                      password = Contrllerpassword.text.toString();

                      try {
                        final User = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (User != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()),
                          );
                        }
                        setState(() {
                          Pshow = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child:
                        CustomButton(color: Colors.green, title: 'Register')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
