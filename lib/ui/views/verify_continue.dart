import 'package:flutter/material.dart';

class VerifyView extends StatelessWidget {
  VerifyView({Key? key, required this.onPressed}) : super(key: key);
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Text(
            "Please verify your email id",
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 29),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(11),
          child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                onPressed();
              },
              child: Container(
                  width: 150,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(
                      "Continue",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white, fontSize: 20),
                    ),
                  )))),
        ),
      ],
    );
  }
}
