import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  const Popup(this.fnc, this.icon, {Key? key}) : super(key: key);
  final Function fnc;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('This Bill has been saved.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                fnc();
                Navigator.pop(context, 'Ok');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: icon,
    );
  }
}
