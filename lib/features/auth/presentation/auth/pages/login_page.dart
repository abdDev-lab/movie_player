import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/configs/theme/app_colors.dart';
import '../bloc/bloc/password_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../../../../home/presentation/home/pages/home_page.dart';
import '../../../../../service_locator.dart';
import 'package:uicons/uicons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => PasswordBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            minimum: const EdgeInsets.only(top: 56, right: 16, left: 16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _loginTitle(),
                  const SizedBox(
                    height: 32,
                  ),
                  _emailField(emailController),
                  const SizedBox(
                    height: 16,
                  ),
                  _passwordField(passwordController),
                  const SizedBox(
                    height: 4,
                  ),
                  _forgetPasswordButton(),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is SuccessLoginState) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false,
                                );
                              } else if (state is ErrorState) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Row(
                                          children: [
                                            Icon(
                                              UIcons
                                                  .regularRounded.cross_circle,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Text(
                                              state.message,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        backgroundColor: Colors.red));
                              }
                            },
                            builder: (context, state) {
                              if (state is LoadingState) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.background,
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                              return ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      BlocProvider.of<LoginBloc>(context).add(
                                          PressLoginEvent(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text));
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _signUpText()
                ],
              ),
            )),
      ),
    );
  }

  Widget _loginTitle() {
    return const Text("Login",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white));
  }

  Widget _emailField(TextEditingController controller) {
    return TextFormField(
      cursorColor: Colors.white,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Email is required";
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: "Email",
      ),
    );
  }

  Widget _passwordField(TextEditingController controller) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Password is required";
            }
            return null;
          },
          cursorColor: Colors.white,
          controller: controller,
          obscureText: !state.showPassword,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () => BlocProvider.of<PasswordBloc>(context)
                  .add(const ChangeShowPasswordEvent()),
              child: Icon(state.showPassword
                  ? CupertinoIcons.eye_solid
                  : CupertinoIcons.eye_slash_fill),
            ),
            hintText: "password",
          ),
        );
      },
    );
  }

  Widget _forgetPasswordButton() {
    return Row(
      children: [
        TextButton(
            style: TextButton.styleFrom(
                overlayColor: const Color.fromRGBO(96, 96, 98, 1)),
            onPressed: () {},
            child: const Text(
              "forget password?",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  Widget _signUpText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text.rich(TextSpan(children: [
        const TextSpan(
            text: "Don't have an account?",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
        TextSpan(
            text: " Sign Up",
            recognizer: TapGestureRecognizer()..onTap = () {},
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white))
      ])),
    );
  }
}
