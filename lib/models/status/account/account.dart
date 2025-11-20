class Account {
  final String? firstName;
  final String? lastName;
  final String? email;

  Account({
    this.firstName,
    this.lastName,
    this.email,
  });

  factory Account.fromMap(Map<String, dynamic> map) => Account(
    firstName: map['firstname'] != null ? map['firstname'] as String : null,
    lastName: map['lastname'] != null ? map['lastname'] as String : null,
    email: map['email'] != null ? map['email'] as String : null,
  );

  @override
  String toString() => 'Account(firstName: $firstName, lastName: $lastName, email: $email)';

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) {
      return true;
    }

    return other.firstName == firstName && other.lastName == lastName && other.email == email;
  }

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ email.hashCode;
}
