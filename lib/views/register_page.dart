import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/google_sign_in/google_sign_in_bloc.dart';
import 'package:flutter_application_1/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_application_1/views/home_page.dart';
import 'package:flutter_application_1/widgets/custom_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            lottie(context),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (state is RegisterSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Successfully Registered"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return _registerForm(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            BlocProvider<GoogleSignInBloc>(
              create: (context) => GoogleSignInBloc(),
              child: BlocConsumer<GoogleSignInBloc, GoogleSignInState>(
                  listener: (context, state) {
                if (state is GoogleSignInSuccess) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              emailId: state.displayEmail,
                            )),
                  );
                }
              }, builder: (context, state) {
                if (state is GoogleSignInLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.only(left: 40, right: 40))),
                  onPressed: () {
                    BlocProvider.of<GoogleSignInBloc>(context)
                        .add(GoogleSignInRequested());
                  },
                  child: const Text('Google sign in'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                textField(
                  inputLabel: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                  onChanged: (email) => context
                      .read<RegisterBloc>()
                      .add(EmailChanged(email ?? "")),
                ),
                const SizedBox(height: 20.0),
                textField(
                  inputLabel: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  onChanged: (password) => context
                      .read<RegisterBloc>()
                      .add(PasswordChanged(password ?? "")),
                ),
                const SizedBox(height: 25.0),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.only(left: 40, right: 40))),
                  onPressed: state.isFormValid
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            _onRegisterButtonPressed(
                                context, _email, _password);
                          }
                        }
                      : null,
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onRegisterButtonPressed(
      BuildContext context, String email, String password) {
    BlocProvider.of<RegisterBloc>(context).add(Submitted(email, password));
  }
}
