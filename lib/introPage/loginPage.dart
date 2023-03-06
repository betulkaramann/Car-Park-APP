import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:car_park/mainPage/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color.fromRGBO(212, 240, 250, 1),
      body: ListView(

        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Lottie.asset('asset/map.json'),),
SizedBox(height: 25,),
          Center(
            child: SizedBox(
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(57, 197, 247,1),
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FadeAnimatedText(textAlign: TextAlign.center,'OTOPARK \nUYGULAMASINA'),
                    FadeAnimatedText(textAlign: TextAlign.center,'\nHOŞGELDİNİZ'),
                    FadeAnimatedText( textAlign: TextAlign.center, 'GİRİŞ İÇİN \nTIKLAYINIZ'),
                  ],
                  onTap: () {
                    print("Home page'e geciliyor");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
