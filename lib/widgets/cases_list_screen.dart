import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/widgets/case_item_screen.dart';
import 'package:to_do/widgets/case_screen.dart';
import 'package:to_do/domain/cubit/remove_case_cubit.dart';
import 'package:to_do/domain/cubit/show_cases_cubit.dart';
import 'package:to_do/domain/model/case.dart';
import 'package:to_do/injection.dart';
import 'package:to_do/widgets/new_case_screen.dart';

class CasesListScreen extends StatelessWidget {
  const CasesListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => inj.showCubit..loadData(),
        ),
        BlocProvider(
          create: (context) => inj.removeCubit,
        ),
      ],
      child: BlocListener<RemoveCaseCubit, RemoveCaseState>(
        listener: (context, state) {
          if (state is RemoveCaseStateReady) {
            context.read<ShowCasesCubit>().loadData();
          } else if (state is RemoveCaseStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.toString()),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('To-do List'),
            actions: [
              Builder(
                builder: (context) {
                  return IconButton(
                      onPressed: () async {
                        final didAdd = await Navigator.of(context).push<bool>(
                              MaterialPageRoute(
                                builder: (ctx) => const NewCaseScreen(),
                              ),
                            ) ??
                            false;
                        if (didAdd) {
                          context.read<ShowCasesCubit>().loadData();
                        }
                      },
                      icon: const Icon(Icons.add));
                },
              ),
            ],
          ),
          body: BlocBuilder<ShowCasesCubit, ShowCasesState>(
            builder: (context, state) {
              return switch (state) {
                ShowCaseStateLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ShowCasesStateError() => Center(
                    child: Column(
                      children: [
                        Text(state.error.toString()),
                        Text(state.st.toString()),
                      ],
                    ),
                  ),
                ShowCasesStateReady() => state.data.isEmpty
                    ? const Center(
                        child: Text('Add a new case now!'),
                      )
                    : ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (ctx, index) =>
                            CaseItemScreen(caseData: state.data[index])),
              };
            },
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
