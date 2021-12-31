import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_roomie/ui/components/avatar.dart';
import 'package:my_roomie/ui/components/text_input.dart';
import 'package:my_roomie/ui/layout/theme.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key, required this.signInSubmit, required this.signUpSubmit})
      : super(key: key);
  dynamic signUpSubmit;
  void Function(String, String) signInSubmit;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool signup = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _blockController = TextEditingController();
  TextEditingController _roomController = TextEditingController();
  int id = 1;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Center(
                      child: Consumer<ThemeNotifier>(
                    builder: (context, value, child) => Avatar(
                      radius: 50,
                      id: value.currentTheme.id,
                      callback: value.changeTheme,
                      color: value.currentTheme.primary,
                    ),
                  )),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(33.0),
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 29),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    cursorColor: Colors.black,
                    controller: _nameController,
                    decoration: InputDecoration(
                        label: Text(
                      "Name ",
                      style: Theme.of(context).textTheme.bodyText1!,
                    )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name.";
                      } else if (!isAlpha(value.replaceAll(RegExp(r' '), ''))) {
                        return "Name should only have alphabets";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    cursorColor: Colors.black,
                    controller: _emailController,
                    decoration: InputDecoration(
                        label: Text(
                      "VIT Email ",
                      style: Theme.of(context).textTheme.bodyText1!,
                    )),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !isEmail(value) ||
                          !value.endsWith('@vitstudent.ac.in')) {
                        return "Please enter your VIT email.";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _passwordController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: Text(
                        "Password ",
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password.";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _phoneController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        label: Text(
                      "Phone ",
                      style: Theme.of(context).textTheme.bodyText1!,
                    )),
                    buildCounter: (context,
                            {required currentLength,
                            required isFocused,
                            maxLength}) =>
                        null,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number.";
                      } else if (!RegExp(r"^[6-9]\d{9}$").hasMatch(value)) {
                        return "Please enter valid Indian number.";
                      }

                      return null;
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 60,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(11, 11, 8, 11),
                        child: TextFormField(
                          controller: _blockController,
                          style: Theme.of(context).textTheme.bodyText1,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            label: Text(
                              "Block ",
                              style: Theme.of(context).textTheme.bodyText1!,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter block";
                            } else if (!isAlpha(value)) {
                              return "Block can only contain letter";
                            }

                            return null;
                          },
                          maxLength: 3,
                          buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  maxLength}) =>
                              null,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 11, 11, 11),
                        child: TextFormField(
                          controller: _roomController,
                          style: Theme.of(context).textTheme.bodyText1,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              label: Text(
                            "Room No. ",
                            style: Theme.of(context).textTheme.bodyText1!,
                          )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter room number.";
                            } else if (!isNumeric(value)) {
                              return "Enter only number";
                            }

                            return null;
                          },
                          buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  maxLength}) =>
                              null,
                          maxLength: 4,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        if (_formKey.currentState!.validate())
                          widget.signUpSubmit(
                              _emailController.text,
                              _passwordController.text,
                              _nameController.text,
                              _phoneController.text,
                              _blockController.text,
                              _roomController.text,
                              Provider.of<ThemeNotifier>(context, listen: false)
                                  .currentTheme
                                  .id);
                      },
                      child: Container(
                          width: double.infinity,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Text(
                              "SIGN UP",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white, fontSize: 18),
                            ),
                          )))),
                ),
                Divider(
                  color: Colors.black54,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a user ? ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18, color: Colors.black54),
                      ),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () {
                            setState(() {
                              signup = !signup;
                            });
                          },
                          child: Text(
                            "Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                      child: Consumer<ThemeNotifier>(
                    builder: (context, value, child) => Avatar(
                      radius: 50,
                      id: value.currentTheme.id,
                      callback: value.changeTheme,
                      color: value.currentTheme.primary,
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(33.0),
                  child: Text(
                    "Sign In",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 29),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _emailController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        label: Text(
                      "VIT Email ",
                      style: Theme.of(context).textTheme.bodyText1!,
                    )),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !isEmail(value) ||
                          !value.endsWith('@vitstudent.ac.in')) {
                        return "Please enter your VIT email.";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    cursorColor: Colors.black,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      label: Text(
                        "Password ",
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password.";
                      }

                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        if (_formKey.currentState!.validate())
                          widget.signInSubmit(
                              _emailController.text, _passwordController.text);
                      },
                      child: Container(
                          width: double.infinity,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Text(
                              "SIGN IN",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white, fontSize: 20),
                            ),
                          )))),
                ),
                Divider(
                  color: Colors.black54,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a user ? ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black54, fontSize: 18)),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          onPressed: () {
                            setState(() {
                              signup = !signup;
                            });
                          },
                          child: Text(
                            "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
