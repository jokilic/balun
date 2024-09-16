import 'package:easy_localization/easy_localization.dart';

import '../models/fixtures/statistic/statistic_data.dart';

String getLastWord(String input) {
  final words = input.split(' ');
  return words.isNotEmpty ? words.last : '';
}

bool matchIsPlaying({
  required String statusShort,
}) =>
    statusShort == '1H' || statusShort == '2H' || statusShort == 'ET';

bool shouldShowTimeBeforeMatch({required String statusShort}) => statusShort == 'TBD' || statusShort == 'NS';

String getMatchStatus(String statusShort) => switch (statusShort.toUpperCase()) {
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

String getMatchStatusMinutes({
  required String statusShort,
  required int minutes,
}) =>
    switch (statusShort.toUpperCase()) {
      'TBD' || 'NS' => '---',
      '1H' || '2H' || 'ET' => '$minutes',
      'FT' || 'AET' || 'PEN' => 'FT',
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
          'goal cancelled' => 'matchEventGoalCancelled'.tr(),
          'penalty confirmed' => 'matchEventPenaltyConfirmed'.tr(),
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

String getCountryName({
  required String country,
}) =>
    switch (country.toLowerCase()) {
      'croatia' => 'Hrv',
      'world' => 'Svijet',
      'europe' => 'Europa',
      'england' => 'Ingleska',
      'spain' => 'Španjulska',
      'bosnia and herzegovina' => 'BiH',
      _ => country,
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
