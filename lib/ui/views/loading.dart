import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.primary, required this.secondary})
      : super(key: key);
  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Stack(
        children: [
          Container(
            color: secondary.withAlpha(180),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(33.0),
                      child: Opacity(
                        opacity: 0.8,
                        child: Image.asset(
                          'lib/assets/loading_cat.gif',
                          height: 200,
                        ),
                      ),
                    ),
                    Center(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        color: primary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(33.0),
                      child: Text(
                        "Just a second...",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
