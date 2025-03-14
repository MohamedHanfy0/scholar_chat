import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/core/assets.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';
import 'package:scholar_chat/core/widgets/show_message_error.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
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
                  onChanged: (emailUser) {
                    email = emailUser;
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  obscureText: true,
                  text: 'Password',
                  onChanged: (passUser) {
                    pass = passUser;
                  },
                ),
                SizedBox(height: 15),
                CustomButton(
                  text: 'resister',
                  click: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: email!,
                              password: pass!,
                            );
                        context.replace('/home');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showMessageError(
                            // ignore: use_build_context_synchronously
                            context,
                            'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          // ignore: use_build_context_synchronously
                          showMessageError(
                            // ignore: use_build_context_synchronously
                            context,
                            'The account already exists for that email.',
                          );
                        } else {
                          showMessageError(
                            // ignore: use_build_context_synchronously
                            context,
                            'Error in email or password.',
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
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
        ),
      ),
    );
  }
}
