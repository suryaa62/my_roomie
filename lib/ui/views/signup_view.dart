import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key, required this.signInSubmit, required this.signUpSubmit})
      : super(key: key);
  dynamic signUpSubmit;
  void Function(String, String) signInSubmit;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  GlobalKey _formKey = GlobalKey<FormState>();
  bool signup = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _blockController = TextEditingController();
  TextEditingController _roomController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: (signup)
          ? Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(label: Text("VIT EMAIL: ")),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(label: Text("Name: ")),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    label: Text("Password : "),
                  ),
                  obscureText: true,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(label: Text("phone no: ")),
                ),
                TextFormField(
                    controller: _blockController,
                    decoration: const InputDecoration(
                      label: Text("hostel block: "),
                    )),
                TextFormField(
                  controller: _roomController,
                  decoration: const InputDecoration(label: Text("room no: ")),
                ),
                ElevatedButton(
                    onPressed: () {
                      widget.signUpSubmit(
                          _emailController.text,
                          _passwordController.text,
                          _nameController.text,
                          _phoneController.text,
                          _blockController.text,
                          _roomController.text);
                    },
                    child: Text("Submit")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        signup = !signup;
                      });
                    },
                    child: Text("Signin")),
              ],
            )
          : Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(label: Text("VIT EMAIL: ")),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    label: Text("Password : "),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      widget.signInSubmit(
                          _emailController.text, _passwordController.text);
                    },
                    child: Text("Submit")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        signup = !signup;
                      });
                    },
                    child: Text("SignUp")),
              ],
            ),
    );
  }
}
