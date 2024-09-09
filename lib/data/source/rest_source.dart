import 'dart:convert';

import 'package:to_do/data/source/dto/case_dto.dart';
import 'package:to_do/domain/model/case.dart';
import 'package:http/http.dart' as http;

class RestSource {
  final url = Uri.https(
    'to-do-list-8c1f3-default-rtdb.firebaseio.com',
    'flutter.json',
  );

  Future<void> addCase(
    String title,
    DateTime time,
    String description,
  ) async {
    if (title.isEmpty) {
      throw Exception('Title must be not empty');
    }
    if (description.isEmpty) {
      throw Exception('Description must be not empty');
    }

    await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: json.encode(
        {
          'title': title,
          'time': time.toIso8601String(),
          'description': description,
        },
      ),
    );
  }

  Future<List<Case>> getCases() async {
    final respose = await http.get(url);

    final List<Case> loadedItem = [];
    final Map<String, dynamic>? data = json.decode(respose.body);

    for (var item in data?.entries.toList() ?? <MapEntry>[]) {
      final dto = CaseDto.fromJson({
        ...item.value,
        'id': item.key,
      });
      loadedItem.add(dto.toDomain());
    }
    return loadedItem;
  }

  Future<void> removeCase(String id) async {
    final url = Uri.https(
      'to-do-list-8c1f3-default-rtdb.firebaseio.com',
      'flutter/$id.json',
    );
    final response = await http.delete(url);
  }
}
