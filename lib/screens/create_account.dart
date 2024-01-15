import "package:flutter/material.dart";
import "package:todo_app/constant/constant.dart";
import "package:todo_app/screens/create_task.dart";
import "package:todo_app/screens/home_screen.dart";
import "package:todo_app/service/auth.dart";

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  bool confirmObsecureText = true;
  bool obsecureText = true;

  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
  );
  loginIn() async {
    if (emailKey.currentState!.validate() &&
        passwordKey.currentState!.validate()) {
      await Auth().signUpWithEmailAndPassword(
          _userEmailController.text, _passwordController.text);
      Constant.userEmail = _userEmailController.text;
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const TaskCard()),
        (route) => false,
      );
      
    }
  }
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.8),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  surfaceTintColor: Colors.white,
                  elevation: 1,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: emailKey,
                          child: TextFormField(
                            controller: _userEmailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !emailRegex.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obsecureText = !obsecureText;
                                  });
                                },
                                child: obsecureText
                                    ? const Icon(
                                        Icons.visibility,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                      )),
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        ),
                        Form(
                          key: passwordKey,
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      confirmObsecureText =
                                          !confirmObsecureText;
                                    });
                                  },
                                  child: confirmObsecureText
                                      ? const Icon(
                                          Icons.visibility,
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                        )),
                              labelText: ' Confirm Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Confirm password is different than password';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            loginIn();
                          },
                          child: const Text(
                            'create account',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
