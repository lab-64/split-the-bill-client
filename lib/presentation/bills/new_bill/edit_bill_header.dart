import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/components/input_text_field.dart';
import 'controllers.dart';

class EditBillHeader extends ConsumerWidget {
  final TextEditingController dateController;
  final TextEditingController nameController;

  const EditBillHeader({
    super.key,
    required this.dateController,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputTextField(
              controller: nameController,
              labelText: 'Name',
              prefixIcon: const Icon(Icons.description),
              onChanged: (name) =>
                  ref.read(editBillControllerProvider.notifier).setName(name),
            ),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputTextField(
              controller: dateController,
              labelText: 'Date',
              prefixIcon: const Icon(Icons.date_range),
              onTap: () => _selectDate(
                  context, ref, DateTime.parse(dateController.text)),
              readOnly: true,
            ),
          ),
        )
      ],
    );
  }

  Future<void> _selectDate(
      BuildContext context, WidgetRef ref, DateTime date) async {
    showDatePicker(
        context: context,
        initialDate: date,
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
        ref.read(editBillControllerProvider.notifier).setDate(selectedDate);
      }
    });
  }
}
