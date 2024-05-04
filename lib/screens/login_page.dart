import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_supabase/configs/routes.dart';
import 'package:flutter_supabase/widgets/dialog_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          showCustomDialog(context, 'successful', const SizedBox());
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, Routes.routeHome);
          });
        } else if (state is AuthFailure) {
          showCustomDialog(context, 'invalid data', const SizedBox());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
          ),
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 40, right: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logos/logo.jpeg', height: 400),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SignInRequested(emailController.text, passwordController.text));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        )),
                    child: const Text('Log In'),
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
