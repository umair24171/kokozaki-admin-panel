// ignore_for_file: use_build_context_synchronously, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kokzaki_admin_panel/controllers/auth_controller.dart';
import 'package:kokzaki_admin_panel/dashboard.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:kokzaki_admin_panel/helper/get_size.dart';
import 'package:kokzaki_admin_panel/helper/loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var authController = Get.put(AuthController());
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      authController.setIsloadingValue(true);
      final String email = _emailController.text;
      final String password = _passwordController.text;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      authController.setIsloadingValue(false);

      // bool isAdmin = false;
      // for (int i = 0; i < snapshot.docs.length; i++) {
      //   isAdmin = snapshot.docs[i].data().containsKey(
      //       {'isAdmin': true});
      // }
      if (userCredential.user != null) {
        // QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        //     .instance
        //     .collection('admin')
        //     .where("email", isEqualTo: email)
        //     .get();
        // Map<String, dynamic> data = snapshot.docs.first.data();

        // if (data['password'] == password && data['isAdmin'] == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
        // }
      }
      // Navigate to the next screen or perform any other action upon successful login
    } catch (e) {
      authController.setIsloadingValue(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      print('Error signing in: $e');
      // Handle sign-in errors, e.g., show a snackbar with an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kokzaki'),
        backgroundColor: secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Signup Section
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(40.0),
                padding: const EdgeInsets.all(40.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(2, 2),
                          blurRadius: 5),
                    ]),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormFIeld(
                        text: "Email",
                        controller: _emailController,
                        focusNode: emailFocusNode,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your email address";
                          } else if (!(val.contains("@"))) {
                            return "Please enter a valid email address";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextFormFIeld(
                        text: "Password",
                        controller: _passwordController,
                        obscureText: true,
                        focusNode: passwordFocusNode,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your password";
                          } else if (val.length <= 7) {
                            return "Password must be at least 8 characters long";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            _signInWithEmailAndPassword();
                          }
                        },
                        child: Obx(
                          () => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: authController.isLoading.value
                                  ? spinKit
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.login,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'Sofia-pro',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
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
            // Company Image Section
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(40),
                // padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black.withOpacity(.2),
                ),
                child: const Image(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  // image: AssetImage("assets/icons/App icon.webp"),
                  // 'https://images.unsplash.com/photo-1598528738936-c50861cc75a9?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Replace with your company image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormFIeld extends StatelessWidget {
  CustomTextFormFIeld(
      {super.key,
      required this.text,
      this.maxLines = 1,
      this.controller,
      this.validator,
      this.focusNode,
      this.onFieldSubmitted,
      this.obscureText = false});
  final String text;
  String? Function(String?)? validator;
  void Function(String)? onFieldSubmitted;
  bool? obscureText;
  int maxLines;
  TextEditingController? controller;
  FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Sofia-pro',
                fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText!,
          decoration: InputDecoration(
            constraints: BoxConstraints(maxWidth: getWidth(context) * 0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.callBack})
      : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Sofia-pro',
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
