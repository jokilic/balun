import 'package:easy_localization/easy_localization.dart';

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
        CoachSectionEnum.info => 'coachSectionInfo'.tr(),
        CoachSectionEnum.career => 'coachSectionCareer'.tr(),
        CoachSectionEnum.sidelined => 'coachSectionSidelined'.tr(),
        CoachSectionEnum.trophies => 'coachSectionTrophies'.tr(),
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
