import 'package:to_do/domain/model/case.dart';

class CaseDto {
  final String id;
  final String title;
  final DateTime time;
  final String description;

  const CaseDto({
    required this.id,
    required this.title,
    required this.time,
    required this.description,
  });

  Case toDomain() => Case(
        id: id,
        title: title,
        time: time,
        description: description,
      );

  factory CaseDto.fromJson(Map<String, dynamic> json) {
    return CaseDto(
        id: json['id'],
        title: json['title'],
        time: DateTime.parse(json['time']),
        description: json['description']);
  }
}
