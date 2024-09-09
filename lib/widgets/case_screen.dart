import 'package:flutter/material.dart';
import 'package:to_do/domain/model/case.dart';
import 'package:to_do/widgets/case_item_screen.dart';

class CaseScreen extends StatelessWidget {
  final Case caseData;

  const CaseScreen(this.caseData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        caseData.title,
        style: const TextStyle(
          fontSize: 24,
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(
                  width: 8,
                ),
                Text(caseData.time.format('MMM/d/y'))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(caseData.description),
          ],
        ),
      ),
    );
  }
}
