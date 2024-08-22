class CountryResponse {
  final String? name;
  final String? code;
  final String? flag;

  CountryResponse({
    this.name,
    this.code,
    this.flag,
  });

  factory CountryResponse.fromMap(Map<String, dynamic> map) => CountryResponse(
        name: map['name'] != null ? map['name'] as String : null,
        code: map['code'] != null ? map['code'] as String : null,
        flag: map['flag'] != null ? map['flag'] as String : null,
      );

  @override
  String toString() => 'CountryResponse(name: $name, code: $code, flag: $flag)';

  @override
  bool operator ==(covariant CountryResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.name == name && other.code == code && other.flag == flag;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ flag.hashCode;
}
