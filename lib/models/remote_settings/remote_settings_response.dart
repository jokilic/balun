class RemoteSettingsResponse {
  final bool mixLogos;
  final bool mixNames;
  final bool hideHighlights;

  RemoteSettingsResponse({
    required this.mixLogos,
    required this.mixNames,
    required this.hideHighlights,
  });

  factory RemoteSettingsResponse.fromMap(Map<String, dynamic> map) => RemoteSettingsResponse(
        mixLogos: map['mixLogos'],
        mixNames: map['mixNames'],
        hideHighlights: map['hideHighlights'],
      );

  @override
  String toString() => 'RemoteSettingsResponse(mixLogos: $mixLogos, mixNames: $mixNames, hideHighlights: $hideHighlights)';

  @override
  bool operator ==(covariant RemoteSettingsResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.mixLogos == mixLogos && other.mixNames == mixNames && other.hideHighlights == hideHighlights;
  }

  @override
  int get hashCode => mixLogos.hashCode ^ mixNames.hashCode ^ hideHighlights.hashCode;
}
