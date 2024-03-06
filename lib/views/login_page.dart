import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/google_sign_in/google_sign_in_bloc.dart';
import 'package:flutter_application_1/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_application_1/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_application_1/repo/user_repo.dart';
import 'package:flutter_application_1/views/home_page.dart';
import 'package:flutter_application_1/views/register_page.dart';
import 'package:flutter_application_1/widgets/custom_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Login")),
      body: BlocProvider(
        create: (context) => LoginBloc(UserRepository()),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Wrong credentials"),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is LoginSuccess) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(
                        emailId: state.user.email,
                      )));
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    lottie(context),
                    const LoginForm(),
                    const SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'New User? ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return BlocProvider<RegisterBloc>(
                                          create: (context) => RegisterBloc(
                                              userRepository: UserRepository()),
                                          child: const RegisterPage(),
                                        );
                                      }),
                                    );
                                  },
                                  child: const Text(
                                    'Register here',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
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
          },
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              textField(
                onChanged: (email) => context
                    .read<LoginBloc>()
                    .add(LoginEmailChanged(email ?? "")),
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
              ),
              const SizedBox(height: 20.0),
              textField(
                onChanged: (password) => context
                    .read<LoginBloc>()
                    .add(LoginPasswordChanged(password ?? "")),
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
                          _onLoginButtonPressed(context);
                        }
                      }
                    : null,
                child: const Text('Login'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(LoginSubmitted(_email, _password));
  }
}
