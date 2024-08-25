enum CoachSectionEnum {
  info,
  career,
  sidelined,
  trophies,
}

class CoachSection {
  final CoachSectionEnum coachSectionEnum;

  CoachSection({
    required this.coachSectionEnum,
  });

  String getCoachSectionName() => switch (coachSectionEnum) {
        CoachSectionEnum.info => 'Info',
        CoachSectionEnum.career => 'Career',
        CoachSectionEnum.sidelined => 'Sidelined',
        CoachSectionEnum.trophies => 'Trophies',
      };

  @override
  String toString() => 'CoachSection(CoachSectionEnum: $CoachSectionEnum)';

  @override
  bool operator ==(covariant CoachSection other) {
    if (identical(this, other)) {
      return true;
    }

    return other.coachSectionEnum == coachSectionEnum;
  }

  @override
  int get hashCode => coachSectionEnum.hashCode;
}
