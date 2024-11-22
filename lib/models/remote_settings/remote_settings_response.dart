class RemoteSettingsResponse {
  final bool mixLogos;
  final bool mixNames;

  RemoteSettingsResponse({
    required this.mixLogos,
    required this.mixNames,
  });

  factory RemoteSettingsResponse.fromMap(Map<String, dynamic> map) => RemoteSettingsResponse(
        mixLogos: map['mixLogos'],
        mixNames: map['mixNames'],
      );

  @override
  String toString() => 'RemoteSettingsResponse(mixLogos: $mixLogos, mixNames: $mixNames)';

  @override
  bool operator ==(covariant RemoteSettingsResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.mixLogos == mixLogos && other.mixNames == mixNames;
  }

  @override
  int get hashCode => mixLogos.hashCode ^ mixNames.hashCode;
}
