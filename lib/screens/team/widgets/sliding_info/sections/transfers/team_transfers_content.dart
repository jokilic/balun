import 'package:flutter/material.dart';

import '../../../../../../models/transfers/transfer_response.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'team_transfers_list_tile.dart';

class TeamTransfersContent extends StatelessWidget {
  final List<TransferResponse>? transfers;

  const TeamTransfersContent({
    required this.transfers,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transfers?.length ?? 0,
        itemBuilder: (_, index) => TeamTransfersListTile(
          transfer: transfers![index],
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
