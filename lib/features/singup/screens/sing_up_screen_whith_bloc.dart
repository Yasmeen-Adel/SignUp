import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iti_project/features/singup/bloc/signup_bloc.dart';
import 'package:iti_project/features/singup/validation/validation_email.dart';
import 'package:iti_project/features/singup/validation/validation_password.dart';

class SingUpScreenWhithBloc extends StatefulWidget {
  const SingUpScreenWhithBloc({super.key});

  @override
  State<SingUpScreenWhithBloc> createState() => _SingUpScreenWhithBlocState();
}

class _SingUpScreenWhithBlocState extends State<SingUpScreenWhithBloc> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc()..add(InitiSingUpScreenEvent()),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          } else if (state is SignUpSuccess) {
            Fluttertoast.showToast(
              msg: "Signup successful!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );

            // ارجع للفورم بعد ظهور التوست، وفضي التيكست فيلدز
            Future.delayed(const Duration(seconds: 2), () {
              _emailController.clear();
              _passwordController.clear();
              _confirmPasswordController.clear();
              context.read<SignUpBloc>().add(InitiSingUpScreenEvent());
            });
          }
        },
        builder: (context, state) {
          if (state is SignUpLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            appBar: AppBar(title: const Text("Sign Up")),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: validationEmailMethod(context: context),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: validationPasswordMethod(context: context),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignUpBloc>().add(
                                SignUpSubmittedEvent(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  confirmPassword:
                                      _confirmPasswordController.text.trim(),
                                ),
                              );
                            }
                          },
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
