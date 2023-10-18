import 'package:flutter/material.dart';

class SaveBillPopup extends StatelessWidget {
  const SaveBillPopup(
      {Key? key, required this.closeFunction, required this.icon})
      : super(key: key);
  final Function closeFunction;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'openSaveBillPopup',
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
                closeFunction();
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
