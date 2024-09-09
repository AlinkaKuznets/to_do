import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/domain/cubit/save_case_cubit.dart';
import 'package:to_do/injection.dart';
import 'package:to_do/widgets/case_item_screen.dart';

class NewCaseScreen extends StatefulWidget {
  const NewCaseScreen({super.key});

  @override
  State<NewCaseScreen> createState() => _NewCaseScreenState();
}

class _NewCaseScreenState extends State<NewCaseScreen> {
  final _selectedDate = ValueNotifier<DateTime?>(null);
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void saveCase(SaveCaseCubit cubit) {
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (_selectedDate.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fill in the "Date" field'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      cubit.addCase(title, _selectedDate.value!, description);
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.add(const Duration(hours: 1)),
      lastDate: now.add(const Duration(days: 14)),
    );
    if (pickedDate != null) {
      _selectedDate.value = pickedDate;
    }
  }

  @override
  void dispose() {
    _selectedDate.dispose();
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inj.addCubit,
      child: BlocListener<SaveCaseCubit, SaveCaseState>(
        listener: (context, state) {
          switch (state) {
            case SaveCaseStateError state:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.toString()),
                ),
              );
            case CaseStateReady _:
              Navigator.of(context).pop(true);
            default:
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add new case'),
          ),
          body: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Name'),
                          ),
                          validator: _validator,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _selectedDate,
                        builder: (context, value, child) => Row(
                          children: [
                            Text(
                              value == null
                                  ? 'No date selected'
                                  : value.format('MMM/d/y'),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: value == null
                                  ? const Icon(
                                      Icons.calendar_month,
                                      color: Color.fromARGB(255, 163, 27, 17),
                                    )
                                  : const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 10,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        label: Text('Description'),
                      ),
                      validator: _validator,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<SaveCaseCubit, SaveCaseState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () =>
                                  saveCase(context.read<SaveCaseCubit>()),
                              child: const Text('Save Expense'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validator(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length > 50) {
      return 'Must be between 1 and 50 characters';
    }
    return null;
  }
}
