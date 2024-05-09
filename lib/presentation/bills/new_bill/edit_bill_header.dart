import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/components/input_text_field.dart';
import 'controllers.dart';

class EditBillHeader extends StatelessWidget {
  final TextEditingController dateController;
  final TextEditingController nameController;
  final WidgetRef ref;

  const EditBillHeader({
    super.key,
    required this.dateController,
    required this.nameController,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputTextField(
              controller: nameController,
              labelText: 'Name*',
              prefixIcon: const Icon(Icons.description),
              onChanged: (name) =>
                  ref.read(editBillControllerProvider.notifier).name = name,
            ),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputTextField(
              controller: dateController,
              labelText: 'Date*',
              prefixIcon: const Icon(Icons.date_range),
              onTap: () => _selectDate(context),
              onChanged: (date) => ref
                  .read(editBillControllerProvider.notifier)
                  .date = DateTime.parse(date),
              readOnly: true,
            ),
          ),
        )
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019, 1),
        lastDate: DateTime.now(),
        builder: (context, picker) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.blue,
                surface: Colors.blue,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.green[900],
            ),
            child: picker!,
          );
        }).then((selectedDate) {
      if (selectedDate != null) {
        dateController.text = selectedDate.toString();
      }
    });
  }
}
