import 'package:flutter/material.dart';
import 'package:librarycom/services/firebase/auth.dart';
import 'package:librarycom/services/firebase/firestore.dart';
import 'package:librarycom/ui/components/my_button.dart';
import 'package:librarycom/ui/components/simple_textfield.dart';
import 'package:librarycom/utils/global_methods.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confrmPasswordController;
  late final TextEditingController usernameController;
  final _key = GlobalKey<FormState>();

  bool _isLoading = false;

  void _register() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      try {
        final auth = Authentication();
        final store = Firestore();
        await auth.register(
          emailController.text.trim(),
          passwordController.text,
        );

        await store.createUserDoc(
          email: emailController.text.trim(),
          username: usernameController.text.trim(),
        );

        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/home",
            (route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          showSnackBar(
            context,
            "Error registering new user: ${e.toString()}",
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confrmPasswordController = TextEditingController();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    confrmPasswordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isLoading ? const LinearProgressIndicator() : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.9,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/icons/community.png",
                            height: 100,
                            width: 100,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Create an account to get started",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 15),
                        // todo: USERNAME TEXTBOX
                        SimpleTextfield(
                          hintText: "Username",
                          controller: emailController,
                        ),
                        const SizedBox(height: 5),

                        // todo: EMAIL TEXTBOX
                        SimpleTextfield(
                          hintText: "Email",
                          controller: emailController,
                        ),
                        const SizedBox(height: 5),

                        // todo: PASSWORD TEXTBOX
                        SimpleTextfield(
                          hintText: "Password",
                          controller: passwordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 5),

                        // todo: CONFIRM PASSWORD TEXTBOX
                        SimpleTextfield(
                          hintText: "Confirm password",
                          controller: confrmPasswordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),

                        // todo: REGISTER BUTTON
                        MyButton(
                          onPressed: _register,
                          btnText: "register",
                        ),
                      ],
                    ),

                    // todo: GOTO LOGIN INSTEAD
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context, "/login", (route) => false),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
