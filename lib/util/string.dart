// ignore_for_file: equal_keys_in_map

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/fixtures/statistic/statistic_data.dart';
import 'date_time.dart';

String getLastWord(String input) {
  final words = input.split(' ');
  return words.isNotEmpty ? words.last : '';
}

String replaceSpecialSymbolsWithStandardLetters(String input) {
  final transliterationMap = {
    // /Croatian
    'č': 'c', 'ć': 'c', 'đ': 'd', 'š': 's', 'ž': 'z',
    'Č': 'C', 'Ć': 'C', 'Đ': 'D', 'Š': 'S', 'Ž': 'Z',

    // /German
    'ä': 'ae', 'ö': 'oe', 'ü': 'ue', 'ß': 'ss',
    'Ä': 'Ae', 'Ö': 'Oe', 'Ü': 'Ue',

    // /French
    'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
    'à': 'a', 'â': 'a', 'ç': 'c',
    'î': 'i', 'ï': 'i',
    'ô': 'o', 'ö': 'o',
    'ù': 'u', 'û': 'u', 'ü': 'u',
    'ÿ': 'y',
    'É': 'E', 'È': 'E', 'Ê': 'E', 'Ë': 'E',
    'À': 'A', 'Â': 'A', 'Ç': 'C',
    'Î': 'I', 'Ï': 'I',
    'Ô': 'O', 'Ö': 'O',
    'Ù': 'U', 'Û': 'U', 'Ü': 'U',
    'Ÿ': 'Y',

    // /Spanish
    'ñ': 'n', 'Ñ': 'N',

    // /Portuguese
    'ã': 'a', 'õ': 'o',
    'Ã': 'A', 'Õ': 'O',

    // /Polish
    'ą': 'a', 'ć': 'c', 'ę': 'e', 'ł': 'l', 'ń': 'n', 'ó': 'o', 'ś': 's', 'ź': 'z', 'ż': 'z',
    'Ą': 'A', 'Ć': 'C', 'Ę': 'E', 'Ł': 'L', 'Ń': 'N', 'Ó': 'O', 'Ś': 'S', 'Ź': 'Z', 'Ż': 'Z',

    // /Romanian
    'ă': 'a', 'â': 'a', 'î': 'i', 'ș': 's', 'ț': 't',
    'Ă': 'A', 'Â': 'A', 'Î': 'I', 'Ș': 'S', 'Ț': 'T',

    // /Other common characters
    'æ': 'ae', 'œ': 'oe',
    'Æ': 'AE', 'Œ': 'OE'
  };

  return input.replaceAllMapped(
    RegExp(r'[^\u0000-\u007F]'),
    (match) => transliterationMap[match.group(0)] ?? match.group(0) ?? '',
  );
}

String getCompactFixtureText({
  required String statusShort,
  required int minutes,
  required DateTime? timestamp,
  required int? homeGoals,
  required int? awayGoals,
  required BuildContext context,
}) {
  final matchNotStarted = isMatchNotStarted(
    statusShort: statusShort,
  );

  if (matchNotStarted && timestamp != null) {
    return DateFormat(
      'HH:mm',
      context.locale.toLanguageTag(),
    ).format(parseTimestamp(timestamp)!);
  }

  return '${homeGoals ?? '--'} : ${awayGoals ?? '--'}';
}

bool isMatchPlaying({
  required String statusShort,
}) =>
    statusShort == '1H' || statusShort == 'HT' || statusShort == '2H' || statusShort == 'ET' || statusShort == 'BT' || statusShort == 'P';

bool isMatchNotStarted({required String statusShort}) => statusShort == 'TBD' || statusShort == 'NS';

bool isMatchFinished({required String statusShort}) => statusShort == 'FT' || statusShort == 'AET' || statusShort == 'PEN';

String getMatchStatusLong(String statusShort) => switch (statusShort.toUpperCase()) {
      'TBD' => 'matchStatusTBD'.tr(),
      'NS' => 'matchStatusNS'.tr(),
      '1H' => 'matchStatus1H'.tr(),
      'HT' => 'matchStatusHT'.tr(),
      '2H' => 'matchStatus2H'.tr(),
      'ET' => 'matchStatusET'.tr(),
      'BT' => 'matchStatusBT'.tr(),
      'P' => 'matchStatusP'.tr(),
      'SUSP' => 'matchStatusSUSP'.tr(),
      'INT' => 'matchStatusINT'.tr(),
      'FT' => 'matchStatusFT'.tr(),
      'AET' => 'matchStatusAET'.tr(),
      'PEN' => 'matchStatusPEN'.tr(),
      'PST' => 'matchStatusPST'.tr(),
      'CANC' => 'matchStatusCANC'.tr(),
      'ABD' => 'matchStatusABD'.tr(),
      'AWD' => 'matchStatusAWD'.tr(),
      'WO' => 'matchStatusWO'.tr(),
      'LIVE' => 'matchStatusLIVE'.tr(),
      _ => 'matchStatusUnknown'.tr(),
    };

// TODO: Return localized abbreviations
String getMatchStatusShortOrMinutes({
  required String statusShort,
  required int minutes,
}) =>
    switch (statusShort.toUpperCase()) {
      'TBD' || 'NS' => '---',
      '1H' || '2H' || 'ET' => '$minutes',
      'HT' => 'HT',
      'AET' => 'ET',
      _ => statusShort,
    };

String getEventText({
  required String eventType,
  required String eventDetail,
}) =>
    switch (eventType.toLowerCase()) {
      'goal' => switch (eventDetail.toLowerCase()) {
          'normal goal' => 'matchEventGoal'.tr(),
          'own goal' => 'matchEventOwnGoal'.tr(),
          'penalty' => 'matchEventPenalty'.tr(),
          'missed penalty' => 'matchEventMissedPenalty'.tr(),
          _ => eventDetail,
        },
      'card' => switch (eventDetail.toLowerCase()) {
          'yellow card' => 'matchEventYellowCard'.tr(),
          'red card' => 'matchEventRedCard'.tr(),
          _ => eventDetail,
        },
      'subst' => 'Substitution',
      'var' => switch (eventDetail.toLowerCase()) {
          'goal confirmed' => 'matchEventGoalConfirmed'.tr(),
          'goal cancelled' => 'matchEventGoalCancelled'.tr(),
          'goal disallowed - offside' => 'matchEventOffside'.tr(),
          'goal disallowed - handball' => 'matchEventHandball'.tr(),
          'penalty confirmed' => 'matchEventPenaltyConfirmed'.tr(),
          'penalty cancelled' => 'matchEventPenaltyCancelled'.tr(),
          'card upgrade' => 'matchEventCardUpgrade'.tr(),
          _ => eventDetail,
        },
      _ => eventType,
    };

String getEventCommentText({
  required String eventComment,
}) =>
    switch (eventComment.toLowerCase()) {
      'argument' => 'matchEventCommentArgument'.tr(),
      'foul' => 'matchEventCommentFoul'.tr(),
      'handball' => 'matchEventCommentHandball'.tr(),
      'time wasting' => 'matchEventCommentTimeWasting'.tr(),
      'simulation' => 'matchEventCommentSimulation'.tr(),
      'unsportsmanlike conduct' => 'matchEventCommentUnsportsmanlikeConduct'.tr(),
      'roughing' => 'matchEventCommentRoughing'.tr(),
      'tripping' => 'matchEventCommentTripping'.tr(),
      'delay of game' => 'matchEventCommentDelayOfGame'.tr(),
      'holding' => 'matchEventCommentHolding'.tr(),
      'off the ball foul' => 'matchEventCommentOffTheBallFoul'.tr(),
      'elbowing' => 'matchEventCommentElbowing'.tr(),
      'persistent fouling' => 'matchEventCommentPersistentFouling'.tr(),
      'handling' => 'matchEventCommentHandling'.tr(),
      'misses next match' => 'matchEventCommentMissesNextMatch'.tr(),
      'serious foul' => 'matchEventCommentSeriousFoul'.tr(),
      _ => eventComment,
    };

String getStatisticText({
  required StatisticData statisticData,
}) =>
    switch (statisticData.type?.toLowerCase()) {
      'shots on goal' => 'matchStatisticShotsOnGoal'.tr(),
      'shots off goal' => 'matchStatisticShotsOffGoal'.tr(),
      'shots insidebox' => 'matchStatisticShotsInsideBox'.tr(),
      'shots outsidebox' => 'matchStatisticShotsOutsideBox'.tr(),
      'total shots' => 'matchStatisticTotalShots'.tr(),
      'blocked shots' => 'matchStatisticBlockedShots'.tr(),
      'fouls' => 'matchStatisticFouls'.tr(),
      'corner kicks' => 'matchStatisticCorners'.tr(),
      'offsides' => 'matchStatisticOffsides'.tr(),
      'ball possession' => 'matchStatisticPossesion'.tr(),
      'yellow cards' => 'matchStatisticYellowCards'.tr(),
      'red cards' => 'matchStatisticRedCards'.tr(),
      'goalkeeper saves' => 'matchStatisticGoalkeeperSaves'.tr(),
      'total passes' => 'matchStatisticTotalPasses'.tr(),
      'passes accurate' => 'matchStatisticAccuratePasses'.tr(),
      'passes %' => 'matchStatisticPassPercentage'.tr(),
      'expected_goals' => 'matchStatisticExpectedGoals'.tr(),
      'goals_prevented' => 'matchStatisticPreventedGoals'.tr(),
      _ => statisticData.type ?? 'matchStatusUnknown'.tr(),
    };

String getPositionText({
  required String position,
}) =>
    switch (position.toLowerCase()) {
      'goalkeeper' => 'playerPositionGoalkeeper'.tr(),
      'defender' => 'playerPositionDefender'.tr(),
      'midfielder' => 'playerPositionMidfielder'.tr(),
      'attacker' => 'playerPositionAttacker'.tr(),
      _ => position,
    };

String getLeagueType({
  required String leagueType,
}) =>
    switch (leagueType.toLowerCase()) {
      'league' => 'leagueTypeLeague'.tr(),
      'cup' => 'leagueTypeCup'.tr(),
      _ => leagueType,
    };

String getTransferType({
  required String transferType,
}) =>
    switch (transferType.toLowerCase()) {
      'free' => 'teamTransferTypeFree'.tr(),
      'loan' => 'teamTransferTypeLoan'.tr(),
      'n/a' => '---',
      _ => transferType,
    };

String getCountryName({
  required String country,
}) =>
    switch (country.toLowerCase()) {
      'world' => 'countryWorld'.tr(),
      'europe' => 'countryEurope'.tr(),
      'croatia' => 'countryCroatia'.tr(),
      'england' => 'countryEngland'.tr(),
      'spain' => 'countrySpain'.tr(),
      'germany' => 'countryGermany'.tr(),
      'italy' => 'countryItaly'.tr(),
      'france' => 'countryFrance'.tr(),
      'albania' => 'countryAlbania'.tr(),
      'algeria' => 'countryAlgeria'.tr(),
      'andorra' => 'countryAndorra'.tr(),
      'angola' => 'countryAngola'.tr(),
      'antigua-and-barbuda' => 'countryAntiguaAndBarbuda'.tr(),
      'argentina' => 'countryArgentina'.tr(),
      'armenia' => 'countryArmenia'.tr(),
      'aruba' => 'countryAruba'.tr(),
      'australia' => 'countryAustralia'.tr(),
      'austria' => 'countryAustria'.tr(),
      'azerbaidjan' => 'countryAzerbaidjan'.tr(),
      'bahrain' => 'countryBahrain'.tr(),
      'bangladesh' => 'countryBangladesh'.tr(),
      'barbados' => 'countryBarbados'.tr(),
      'belarus' => 'countryBelarus'.tr(),
      'belgium' => 'countryBelgium'.tr(),
      'belize' => 'countryBelize'.tr(),
      'benin' => 'countryBenin'.tr(),
      'bermuda' => 'countryBermuda'.tr(),
      'bhutan' => 'countryBhutan'.tr(),
      'bolivia' => 'countryBolivia'.tr(),
      'bosnia' => 'countryBosnia'.tr(),
      'bosnia and herzegovina' => 'countryBosniaAndHerzegovina'.tr(),
      'botswana' => 'countryBotswana'.tr(),
      'brazil' => 'countryBrazil'.tr(),
      'bulgaria' => 'countryBulgaria'.tr(),
      'burkina-faso' => 'countryBurkinaFaso'.tr(),
      'burundi' => 'countryBurundi'.tr(),
      'cambodia' => 'countryCambodia'.tr(),
      'cameroon' => 'countryCameroon'.tr(),
      'canada' => 'countryCanada'.tr(),
      'chile' => 'countryChile'.tr(),
      'china' => 'countryChina'.tr(),
      'chinese-taipei' => 'countryChineseTaipei'.tr(),
      'colombia' => 'countryColombia'.tr(),
      'congo' => 'countryCongo'.tr(),
      'congo-dr' => 'countryCongodr'.tr(),
      'costa-rica' => 'countryCostaRica'.tr(),
      'crimea' => 'countryCrimea'.tr(),
      'cuba' => 'countryCuba'.tr(),
      'curacao' => 'countryCuracao'.tr(),
      'cyprus' => 'countryCyprus'.tr(),
      'czech-republic' => 'countryCzechRepublic'.tr(),
      'denmark' => 'countryDenmark'.tr(),
      'dominican-republic' => 'countryDominicanRepublic'.tr(),
      'ecuador' => 'countryEcuador'.tr(),
      'egypt' => 'countryEgypt'.tr(),
      'el-salvador' => 'countryElSalvador'.tr(),
      'estonia' => 'countryEstonia'.tr(),
      'eswatini' => 'countryEswatini'.tr(),
      'ethiopia' => 'countryEthiopia'.tr(),
      'faroe-islands' => 'countryFaroeIslands'.tr(),
      'fiji' => 'countryFiji'.tr(),
      'finland' => 'countryFinland'.tr(),
      'gabon' => 'countryGabon'.tr(),
      'gambia' => 'countryGambia'.tr(),
      'georgia' => 'countryGeorgia'.tr(),
      'ghana' => 'countryGhana'.tr(),
      'gibraltar' => 'countryGibraltar'.tr(),
      'greece' => 'countryGreece'.tr(),
      'grenada' => 'countryGrenada'.tr(),
      'guadeloupe' => 'countryGuadeloupe'.tr(),
      'guatemala' => 'countryGuatemala'.tr(),
      'guinea' => 'countryGuinea'.tr(),
      'haiti' => 'countryHaiti'.tr(),
      'honduras' => 'countryHonduras'.tr(),
      'hong-kong' => 'countryHongKong'.tr(),
      'hungary' => 'countryHungary'.tr(),
      'iceland' => 'countryIceland'.tr(),
      'india' => 'countryIndia'.tr(),
      'indonesia' => 'countryIndonesia'.tr(),
      'iran' => 'countryIran'.tr(),
      'iraq' => 'countryIraq'.tr(),
      'ireland' => 'countryIreland'.tr(),
      'israel' => 'countryIsrael'.tr(),
      'ivory-coast' => 'countryIvoryCoast'.tr(),
      'jamaica' => 'countryJamaica'.tr(),
      'japan' => 'countryJapan'.tr(),
      'jordan' => 'countryJordan'.tr(),
      'kazakhstan' => 'countryKazakhstan'.tr(),
      'kenya' => 'countryKenya'.tr(),
      'kosovo' => 'countryKosovo'.tr(),
      'kuwait' => 'countryKuwait'.tr(),
      'kyrgyzstan' => 'countryKyrgyzstan'.tr(),
      'laos' => 'countryLaos'.tr(),
      'latvia' => 'countryLatvia'.tr(),
      'lebanon' => 'countryLebanon'.tr(),
      'lesotho' => 'countryLesotho'.tr(),
      'liberia' => 'countryLiberia'.tr(),
      'libya' => 'countryLibya'.tr(),
      'liechtenstein' => 'countryLiechtenstein'.tr(),
      'lithuania' => 'countryLithuania'.tr(),
      'luxembourg' => 'countryLuxembourg'.tr(),
      'macao' => 'countryMacao'.tr(),
      'macedonia' => 'countryMacedonia'.tr(),
      'malawi' => 'countryMalawi'.tr(),
      'malaysia' => 'countryMalaysia'.tr(),
      'maldives' => 'countryMaldives'.tr(),
      'mali' => 'countryMali'.tr(),
      'malta' => 'countryMalta'.tr(),
      'mauritania' => 'countryMauritania'.tr(),
      'mauritius' => 'countryMauritius'.tr(),
      'mexico' => 'countryMexico'.tr(),
      'moldova' => 'countryMoldova'.tr(),
      'mongolia' => 'countryMongolia'.tr(),
      'montenegro' => 'countryMontenegro'.tr(),
      'morocco' => 'countryMorocco'.tr(),
      'myanmar' => 'countryMyanmar'.tr(),
      'namibia' => 'countryNamibia'.tr(),
      'nepal' => 'countryNepal'.tr(),
      'netherlands' => 'countryNetherlands'.tr(),
      'new-zealand' => 'countryNewZealand'.tr(),
      'nicaragua' => 'countryNicaragua'.tr(),
      'nigeria' => 'countryNigeria'.tr(),
      'northern-ireland' => 'countryNorthernIreland'.tr(),
      'norway' => 'countryNorway'.tr(),
      'oman' => 'countryOman'.tr(),
      'pakistan' => 'countryPakistan'.tr(),
      'palestine' => 'countryPalestine'.tr(),
      'panama' => 'countryPanama'.tr(),
      'paraguay' => 'countryParaguay'.tr(),
      'peru' => 'countryPeru'.tr(),
      'philippines' => 'countryPhilippines'.tr(),
      'poland' => 'countryPoland'.tr(),
      'portugal' => 'countryPortugal'.tr(),
      'qatar' => 'countryQatar'.tr(),
      'romania' => 'countryRomania'.tr(),
      'russia' => 'countryRussia'.tr(),
      'rwanda' => 'countryRwanda'.tr(),
      'san-marino' => 'countrySanMarino'.tr(),
      'saudi-arabia' => 'countrySaudiArabia'.tr(),
      'scotland' => 'countryScotland'.tr(),
      'senegal' => 'countrySenegal'.tr(),
      'serbia' => 'countrySerbia'.tr(),
      'singapore' => 'countrySingapore'.tr(),
      'slovakia' => 'countrySlovakia'.tr(),
      'slovenia' => 'countrySlovenia'.tr(),
      'somalia' => 'countrySomalia'.tr(),
      'south-africa' => 'countrySouthAfrica'.tr(),
      'south-korea' => 'countrySouthKorea'.tr(),
      'sudan' => 'countrySudan'.tr(),
      'surinam' => 'countrySurinam'.tr(),
      'sweden' => 'countrySweden'.tr(),
      'switzerland' => 'countrySwitzerland'.tr(),
      'syria' => 'countrySyria'.tr(),
      'tajikistan' => 'countryTajikistan'.tr(),
      'tanzania' => 'countryTanzania'.tr(),
      'thailand' => 'countryThailand'.tr(),
      'togo' => 'countryTogo'.tr(),
      'trinidad-and-tobago' => 'countryTrinidadAndTobago'.tr(),
      'tunisia' => 'countryTunisia'.tr(),
      'turkey' => 'countryTurkey'.tr(),
      'turkmenistan' => 'countryTurkmenistan'.tr(),
      'usa' => 'countryUsa'.tr(),
      'uganda' => 'countryUganda'.tr(),
      'ukraine' => 'countryUkraine'.tr(),
      'united-arab-emirates' => 'countryUnitedArabEmirates'.tr(),
      'uruguay' => 'countryUruguay'.tr(),
      'uzbekistan' => 'countryUzbekistan'.tr(),
      'venezuela' => 'countryVenezuela'.tr(),
      'vietnam' => 'countryVietnam'.tr(),
      'wales' => 'countryWales'.tr(),
      'yemen' => 'countryYemen'.tr(),
      'zambia' => 'countryZambia'.tr(),
      'zimbabwe' => 'countryZimbabwe'.tr(),
      _ => country,
    };
