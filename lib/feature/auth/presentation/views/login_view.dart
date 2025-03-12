// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:scholar_chat/core/assets.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.assetsIconsMortarboard, width: 120, height: 120),
            Text(
              "Scholar Chat",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 25),
              alignment: Alignment.centerLeft,
              child: Text(
                'LogIn',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            CustomTextField(text: 'Email', onChanged: (String ) {  },),
            SizedBox(height: 15),
            CustomTextField(text: 'Password', onChanged: (String ) {  },),
            SizedBox(height: 15),
            CustomButton(text: 'login', click: () {  },),
            Container(
              // alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 20),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Text("Dont have an account"),

                  InkWell(
                    onTap: () {
                      context.go('/register');
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.orange),
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
