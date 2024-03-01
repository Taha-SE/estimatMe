// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Estimation {
  final int count;
  final String name;
  final int age;
  Estimation({
    required this.count,
    required this.name,
    required this.age,
  });

  Estimation copyWith({
    int? count,
    String? Name,
    int? age,
  }) {
    return Estimation(
      count: count ?? this.count,
      name: Name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'Name': name,
      'age': age,
    };
  }

  factory Estimation.fromMap(Map<String, dynamic> map) {
    return Estimation(
      count: map['count'] as int,
      name: map['name'] as String,
      age: map['age'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Estimation.fromJson(String source) =>
      Estimation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Estimation(count: $count, Name: $name, age: $age)';

  @override
  bool operator ==(covariant Estimation other) {
    if (identical(this, other)) return true;

    return other.count == count && other.name == name && other.age == age;
  }

  @override
  int get hashCode => count.hashCode ^ name.hashCode ^ age.hashCode;
}
