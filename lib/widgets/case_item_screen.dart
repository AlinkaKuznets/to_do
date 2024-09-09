import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/domain/cubit/remove_case_cubit.dart';
import 'package:to_do/domain/model/case.dart';
import 'package:to_do/injection.dart';
import 'package:to_do/widgets/case_screen.dart';

class CaseItemScreen extends StatelessWidget {
  final Case caseData;

  const CaseItemScreen({super.key, required this.caseData});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => inj.removeCubit,
        ),
        BlocProvider(
          create: (context) => inj.showCubit..loadData(),
        ),
      ],
      child: Dismissible(
        key: ValueKey(caseData.id),
        onDismissed: (direction) =>
            context.read<RemoveCaseCubit>().removeItem(caseData.id),
        child: SizedBox(
          height: 130,
          child: GestureDetector(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      caseData.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 33, 161, 220),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.punch_clock),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          caseData.time.format('MMM/d/y'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      caseData.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () => Navigator.of(context).push<Case>(
              MaterialPageRoute(
                builder: (ctx) => CaseScreen(caseData),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension DateFormating on DateTime {
  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }
}
