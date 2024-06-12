import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/shared/components/input_text_field.dart';

class GeneralTab extends ConsumerStatefulWidget {
  const GeneralTab({super.key, required this.bill});

  final Bill bill;

  @override
  ConsumerState<GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends ConsumerState<GeneralTab> {
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.bill.name);
    dateController = TextEditingController(
      text: parseDateToString(
        widget.bill.date,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  String parseDateToString(DateTime date) {
    final dateFormat = DateFormat("dd.MM.yyyy");
    return dateFormat.format(date);
  }

  Future<void> _selectDate(BuildContext context, String dateString) async {
    final dateFormat = DateFormat("dd.MM.yyyy");

    final date = dateFormat.parse(dateString);

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
        dateController.text = parseDateToString(selectedDate);
        ref.read(editBillControllerProvider.notifier).setDate(selectedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
      child: Column(
        children: [
          gapH16,
          InputTextField(
            autofocus: true,
            hintText: widget.bill.name == '' && widget.bill.items.isNotEmpty
                ? widget.bill.items[0].name
                : null,
            controller: nameController,
            labelText: 'Bill Name*',
            prefixIcon: const Icon(Icons.description),
            onChanged: (name) => {
              ref.read(editBillControllerProvider.notifier).setName(name),
            },
            textInputAction: TextInputAction.next,
          ),
          gapH16,
          InputTextField(
            controller: dateController,
            labelText: 'Bill Date',
            prefixIcon: const Icon(Icons.date_range),
            onTap: () => {_selectDate(context, dateController.text)},
            readOnly: true,
          )
        ],
      ),
    );
  }
}
