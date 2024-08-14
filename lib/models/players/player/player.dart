import 'birth.dart';

class Player {
  final int? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final int? age;
  final Birth? birth;
  final String? nationality;
  final String? height;
  final String? weight;
  final bool? injured;
  final String? photo;

  Player({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.age,
    this.birth,
    this.nationality,
    this.height,
    this.weight,
    this.injured,
    this.photo,
  });

  factory Player.fromMap(Map<String, dynamic> map) => Player(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        firstName: map['firstName'] != null ? map['firstName'] as String : null,
        lastName: map['lastName'] != null ? map['lastName'] as String : null,
        age: map['age'] != null ? map['age'] as int : null,
        birth: map['birth'] != null ? Birth.fromMap(map['birth'] as Map<String, dynamic>) : null,
        nationality: map['nationality'] != null ? map['nationality'] as String : null,
        height: map['height'] != null ? map['height'] as String : null,
        weight: map['weight'] != null ? map['weight'] as String : null,
        injured: map['injured'] != null ? map['injured'] as bool : null,
        photo: map['photo'] != null ? map['photo'] as String : null,
      );

  @override
  String toString() =>
      'Player(id: $id, name: $name, firstName: $firstName, lastName: $lastName, age: $age, birth: $birth, nationality: $nationality, height: $height, weight: $weight, injured: $injured, photo: $photo)';

  @override
  bool operator ==(covariant Player other) {
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
        other.injured == injured &&
        other.photo == photo;
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
      injured.hashCode ^
      photo.hashCode;
}
