import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/auth.dart';
import 'package:todo_app/controller/provider.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/view/screens/forgot_screen.dart';
import 'package:todo_app/view/screens/home_screen.dart';
import 'package:todo_app/view/screens/signup.dart';
import 'package:todo_app/view/widgets/custom_button_widget.dart';
import 'package:todo_app/view/widgets/default_form_filed_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Auth auth = Auth();
  String? email;
  String? password;

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
              height: screenSize.height * 1,
              width: screenSize.width * 1,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: screenSize.height * 0.14,
                      width: screenSize.width * 0.3,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                          )),
                      child: Center(
                        child: Container(
                          height: screenSize.height * 0.07,
                          width: screenSize.width * 0.14,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 180.0,
              bottom: 0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: screenSize.height * 0.7,
                width: screenSize.width * 1,
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
                        height: screenSize.height * 0.03,
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 50.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 25.0,
                          left: 25.0,
                        ),
                        child: Column(
                          children: [
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
                                suffix: provider.suffix,
                                obscureText: provider.isPassword,
                                suffixTab: () {
                                  setState(() {
                                    provider.changeVisibility();
                                  });
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, ForgotScreen());
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey.shade800),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.075,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 25.0,
                          left: 25.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            validateLogin(
                                formKey, auth, email, password, context);
                          },
                          child: customButton(
                            text: 'Login',
                            screenSize: screenSize,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have any account? ',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, SignUpScreen());
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            indent: 60,
                            endIndent: 12,
                          )),
                          Text(
                            "OR",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.grey),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            endIndent: 60,
                            indent: 12,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.045,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              try {
                                await auth.signInWithGoogle();
                                navigateAndRemoveUntil(context, HomeScreen());
                              } catch (error) {
                                print(error.toString());
                              }
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.0,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/google.png',
                                ),
                                width: 45,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.12,
                          ),
                          InkWell(
                            onTap: () async {
                              try {
                                await auth.signInWithFacebook();
                                navigateAndRemoveUntil(context, HomeScreen());
                              } on FirebaseAuthException catch (e) {
                                print(e.toString());
                                String? title;
                                facebookException(e, title);
                                showToast(
                                    text: title.toString(),
                                    state: ToastState.error);
                              }
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.0,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/facebook.png',
                                ),
                              ),
                            ),
                          ),
                        ],
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
