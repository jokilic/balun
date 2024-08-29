import 'package:flutter/foundation.dart';

import 'birth/birth.dart';
import 'career/career.dart';
import 'team/team.dart';

class SearchCoachResponse {
  final int? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final int? age;
  final Birth? birth;
  final String? nationality;
  final String? height;
  final String? weight;
  final String? photo;
  final Team? team;
  final List<Career>? career;

  SearchCoachResponse({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.age,
    this.birth,
    this.nationality,
    this.height,
    this.weight,
    this.photo,
    this.team,
    this.career,
  });

  factory SearchCoachResponse.fromMap(Map<String, dynamic> map) => SearchCoachResponse(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        firstName: map['firstname'] != null ? map['firstname'] as String : null,
        lastName: map['lastname'] != null ? map['lastname'] as String : null,
        age: map['age'] != null ? map['age'] as int : null,
        birth: map['birth'] != null ? Birth.fromMap(map['birth'] as Map<String, dynamic>) : null,
        nationality: map['nationality'] != null ? map['nationality'] as String : null,
        height: map['height'] != null ? map['height'] as String : null,
        weight: map['weight'] != null ? map['weight'] as String : null,
        photo: map['photo'] != null ? map['photo'] as String : null,
        team: map['team'] != null ? Team.fromMap(map['team'] as Map<String, dynamic>) : null,
        career: map['career'] != null
            ? List<Career>.from(
                (map['career'] as List).map<Career?>(
                  (x) => Career.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() =>
      'SearchCoachResponse(id: $id, name: $name, firstName: $firstName, lastName: $lastName, age: $age, birth: $birth, nationality: $nationality, height: $height, weight: $weight, photo: $photo, team: $team, career: $career)';

  @override
  bool operator ==(covariant SearchCoachResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id &&
        other.name == name &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.age == age &&
        other.birth == birth &&
        other.nationality == nationality &&
        other.height == height &&
        other.weight == weight &&
        other.photo == photo &&
        other.team == team &&
        listEquals(other.career, career);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      age.hashCode ^
      birth.hashCode ^
      nationality.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      photo.hashCode ^
      team.hashCode ^
      career.hashCode;
}
