// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scholar_chat/core/assets.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';

class SigninView extends StatelessWidget {
  String? email;
  String? pass;
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
                'Register',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            CustomTextField(
              text: 'Email',
              onChanged: (email) {
                email = email;
              },
            ),
            SizedBox(height: 15),
            CustomTextField(
              text: 'Password',
              onChanged: (pass) {
                pass = pass;
              },
            ),
            SizedBox(height: 15),
            CustomButton(text: 'resister', click: () { 
              
             },),

            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Text("Alrady Have an account"),

                  InkWell(
                    onTap: () {
                      context.go('/login');
                    },
                    child: Text(
                      "Login",
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
