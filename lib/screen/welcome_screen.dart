import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/Custom_widget/Custom_Button.dart';
import 'package:flash_chat/screen/Sign_in.dart';
import 'package:flash_chat/screen/Sing-Up.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutCubicEmphasized);
    animationController.forward();

    animationController.addListener(() {
      setState(() {});

      print(animation.value);
    });
    //animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.withOpacity(animationController.value),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: animation.value * 60.toInt(),
                ),
                SizedBox(
                  height: 30,
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('FLASH CHAT'),
                        TypewriterAnimatedText('FLASH CHAT'),
                        TypewriterAnimatedText('FLASH CHAT'),
                      ],
                      onTap: () {
                        print('Flash Chat is tapped');
                      },

                      // totalRepeatCount: 5,
                      repeatForever: true,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );

                  // Navigation Here of Sign in
                },
                child: CustomButton(title: 'Sign In', color: Colors.blue)),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  //Navigation here of Sing Up
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
                child: CustomButton(
                  color: Colors.green,
                  title: 'Sign Up',
                ))
          ],
        ),
      )),
    );
  }
}
