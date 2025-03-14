// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:scholar_chat/core/assets.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';
import 'package:scholar_chat/core/widgets/show_message_error.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.assetsIconsMortarboard,
                  width: 120,
                  height: 120,
                ),
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
                CustomTextField(
                  text: 'Email',
                  onChanged: (valueEmail) {
                    email = valueEmail;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  text: 'Password',
                  obscureText: true,
                  onChanged: (valuePass) {
                    pass = valuePass;
                  },
                ),
                SizedBox(height: 15),
                CustomButton(
                  text: 'login',
                  click: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: email!,
                              password: pass!,
                            );
                        // ignore: use_build_context_synchronously
                        context.replace('/home');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          // ignore: use_build_context_synchronously
                          showMessageError(
                            // ignore: use_build_context_synchronously
                            context,
                            'No user found for that email.',
                          );
                        } else if (e.code == 'wrong-password') {
                          // ignore: use_build_context_synchronously
                          showMessageError(
                            // ignore: use_build_context_synchronously
                            context,
                            'Wrong password provided for that user.',
                          );
                        } else {
                          showMessageError(
                            // ignore: use_build_context_synchronously
                            context,
                            'Error in email or password.',
                          );
                        }
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showMessageError(context, e);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
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
        ),
      ),
    );
  }
}
