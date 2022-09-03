import 'package:flutter/material.dart';
import 'package:todo_app/controller/auth.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/view/widgets/custom_button_widget.dart';
import 'package:todo_app/view/widgets/default_form_filed_widget.dart';

class ForgotScreen extends StatelessWidget {
  TextEditingController forgotController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                const Image(
                  image: AssetImage('assets/images/Forgot password.png'),
                  width: 220,
                  height: 220,
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 31.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                const Text(
                  'No worries, we\'ll send you reset instructions',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    right: 25.0,
                    left: 25.0,
                  ),
                  child: defaultFormFiled(
                    label: 'Email',
                    hint: 'Enter Your Email',
                    type: TextInputType.emailAddress,
                    controller: forgotController,
                    validate: validateEmail,
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
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate()) {
                        try {
                          auth.forgotPassword(forgotController.text);
                          showToast(
                            text: 'Check Your Email',
                            state: ToastState.success,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('$e')));
                        }
                      }
                    },
                    child: customButton(
                        screenSize: screenSize, text: 'Reset password'),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.arrow_back,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'Back To LogIn',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
