import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenderRadio extends StatefulWidget {
  const GenderRadio(
      {Key? key,
      required this.primary,
      required this.secondary,
      required this.callback})
      : super(key: key);
  final Color primary;
  final Color secondary;
  final void Function(String) callback;

  @override
  _GenderRadioState createState() => _GenderRadioState();
}

class _GenderRadioState extends State<GenderRadio> {
  String value = 'None';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio(
              fillColor: MaterialStateProperty.all(widget.primary),
              //activeColor: widget.secondary,
              value: 'M',
              groupValue: value,
              onChanged: (v) {
                setState(() {
                  value = v.toString();
                  widget.callback(v.toString());
                });
              },
            ),
            Text(
              'M',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              fillColor: MaterialStateProperty.all(widget.primary),
              //activeColor: widget.primary,
              value: 'F',
              groupValue: value,
              onChanged: (v) {
                setState(() {
                  value = v.toString();
                  widget.callback(v.toString());
                });
              },
            ),
            Text(
              'F',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        )
      ],
    );
  }
}
