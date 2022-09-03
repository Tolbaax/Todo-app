import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/auth.dart';
import 'package:todo_app/controller/provider.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/view/screens/login/login_screen.dart';
import 'package:todo_app/view/widgets/custom_button_widget.dart';
import 'package:todo_app/view/widgets/default_form_filed_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Auth auth = Auth();
  String? email, password, name;

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: screenSize.height,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 45.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.22,
                    ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 145.0,
              bottom: 0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: screenSize.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(70.0),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 25.0,
                          left: 25.0,
                        ),
                        child: Column(
                          children: [
                            defaultFormFiled(
                              label: 'Name',
                              hint: 'Enter your name',
                              type: TextInputType.name,
                              onSaved: (v) {
                                name = v;
                              },
                              validate: validateName,
                            ),
                            SizedBox(
                              height: screenSize.height * 0.05,
                            ),
                            defaultFormFiled(
                              label: 'Email',
                              hint: 'Enter your email',
                              type: TextInputType.emailAddress,
                              onSaved: (v) {
                                email = v;
                              },
                              validate: validateEmail,
                            ),
                            SizedBox(
                              height: screenSize.height * 0.05,
                            ),
                            defaultFormFiled(
                              label: 'Password',
                              hint: 'Enter your password',
                              type: TextInputType.visiblePassword,
                              onSaved: (v) {
                                password = v;
                              },
                              validate: validatePassword,
                              obscureText: provider.isPassword,
                              suffix: provider.suffix,
                              suffixTab: () {
                                setState(() {
                                  provider.changeVisibility();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 25.0,
                          left: 25.0,
                        ),
                        child: InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();

                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              try {
                                await auth.signUp(email, password, name);
                                showToast(
                                  text: 'Registered Successfully',
                                  state: ToastState.success,
                                );
                                navigateTo(context, LoginScreen());
                              } on FirebaseAuthException catch (error) {
                                if (kDebugMode) {
                                  print(error);
                                }
                                if (error.code == 'email-already-in-use') {
                                  showToast(
                                    text: 'This email address is already taken',
                                    state: ToastState.error,
                                  );
                                }
                              }
                            }
                          },
                          child: customButton(
                            screenSize: screenSize,
                            text: 'Sign Up',
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have any account? ',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, LoginScreen());
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.065,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String? validateName(String? value) {
  if (value!.isEmpty) {
    return 'Please Enter your Name';
  }
  if (value.length < 2) {
    return 'Name must be at least 2 characters long';
  }
  if (value.length > 50) {
    return 'Name must be less than 50 characters long';
  }
  return null;
}
