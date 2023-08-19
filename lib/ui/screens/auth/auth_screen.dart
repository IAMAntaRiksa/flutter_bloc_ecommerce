import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/core/models/auth/auth_request.dart';
import 'package:flutter_app_ecommerce/core/utils/token/token_utils.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/login/login_bloc.dart';
import 'package:flutter_app_ecommerce/core/viewmodels/register/register_bloc.dart';
import 'package:flutter_app_ecommerce/ui/constant/constant.dart';
import 'package:flutter_app_ecommerce/ui/screens/home/home_screen.dart';
import 'package:flutter_app_ecommerce/ui/widgets/buttom/custome_buttom.dart';
import 'package:flutter_app_ecommerce/ui/widgets/textfield/custome_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  tileColor: _auth == Auth.signin ? blackBGColor : grayColor,
                  title: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  leading: Radio(
                    activeColor: grayDarkColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          QCustomeTextField(
                            controller: _nameController,
                            label: 'Name',
                            onChanged: (p0) {},
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                val = "Name";
                                return 'Enter your $val';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          QCustomeTextField(
                            controller: _emailController,
                            label: 'Email',
                            onChanged: (p0) {},
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                val = "Email";
                                return 'Enter your $val';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          QCustomeTextField(
                            controller: _passwordController,
                            label: 'Password',
                            onChanged: (p0) {},
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                val = "Password";
                                return 'Enter your $val';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          BlocConsumer<RegisterBloc, RegisterState>(
                            listener: (context, state) {
                              state.maybeWhen(
                                orElse: () {},
                                error: (data) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(data)),
                                  );
                                },
                                loaded: (model) async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                            'Register Succses ,${model.user!.username}')),
                                  );
                                  await setToken.saveTokenUser(model);
                                  // ignore: use_build_context_synchronously
                                  context.push(HomeScreen.routeName);
                                },
                              );
                            },
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return ECustomButton(
                                    text: 'Sign Up',
                                    onTap: () {
                                      if (_signUpFormKey.currentState!
                                          .validate()) {
                                        final requestModel =
                                            RegisterRequestModel(
                                          name: _nameController.text,
                                          password: _passwordController.text,
                                          email: _emailController.text,
                                          username: _nameController.text,
                                        );

                                        context.read<RegisterBloc>().add(
                                            RegisterEvent.getRegister(
                                                requestModel));
                                      }
                                    },
                                  );
                                },
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signin ? grayColor : blackBGColor,
                  title: const Text(
                    'Sign-In.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  leading: Radio(
                    activeColor: darkColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          QCustomeTextField(
                            controller: _emailController,
                            label: 'Email',
                            onChanged: (p0) {},
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                val = "Email";
                                return 'Enter your $val';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          QCustomeTextField(
                            controller: _passwordController,
                            label: 'Password',
                            onChanged: (p0) {},
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                val = "Password";
                                return 'Enter your $val';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) async {
                              state.maybeWhen(
                                orElse: () {},
                                error: (data) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(data),
                                    ),
                                  );
                                },
                                loaded: (model) async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                            'Login Succses : ${model.user!.username}')),
                                  );
                                  await setToken.saveTokenUser(model);
                                  // ignore: use_build_context_synchronously
                                  context.push(HomeScreen.routeName);
                                },
                              );
                            },
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return ECustomButton(
                                    text: 'Sign In',
                                    onTap: () {
                                      if (_signInFormKey.currentState!
                                          .validate()) {
                                        final model = LoginRequestModel(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );
                                        context
                                            .read<LoginBloc>()
                                            .add(LoginEvent.getLogin(model));
                                      }
                                    },
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffEE4D2D)),
                      onPressed: () {
                        context.push(HomeScreen.routeName);
                      },
                      child: const Text(
                        'Continue as a Guest',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
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
