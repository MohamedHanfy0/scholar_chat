import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/core/assets.dart';
import 'package:scholar_chat/core/widgets/custom_button.dart';
import 'package:scholar_chat/core/widgets/custom_text_field.dart';
import 'package:scholar_chat/feature/auth/cubits/register_cubit/register_cubit.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            isLoading = true;
          } else if (state is RegisterFailure) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ),
            );
          } else if (state is RegisterSuccess) {
            isLoading = false;
            context.replace('/chat');
          }
        },
        builder:
            (context, state) => ModalProgressHUD(
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
                            BlocProvider.of<RegisterCubit>(
                              context,
                            ).createUserWithEmailAndPassword(
                              email: email!,
                              pass: pass!,
                            );
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
      ),
    );
  }
}
