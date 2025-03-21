// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:scholar_chat/core/assets.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';
import 'package:scholar_chat/feature/auth/cubits/login_cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    GlobalKey<FormState> formKey = GlobalKey();
    String? email;
    String? pass;
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            context.replace('/chat');
            isLoading = false;
          } else if (state is LoginFailure) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,

                content: Text(state.message),
              ),
            );
          }
        },
        builder:
            (context, stat) => ModalProgressHUD(
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
                            BlocProvider.of<LoginCubit>(
                              context,
                            ).signInWithEmailAndPassword(
                              email: email!,
                              pass: pass!,
                            );
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
      ),
    );
  }
}
