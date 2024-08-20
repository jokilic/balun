import 'package:flutter/material.dart';

import '../../../../../../models/transfers/transfer/transfer.dart';
import '../../../../../../widgets/balun_seperator.dart';
import 'player_transfer_list_tile.dart';

class PlayerTransfersContent extends StatelessWidget {
  final List<Transfer>? transfers;

  const PlayerTransfersContent({
    required this.transfers,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transfers?.length ?? 0,
        itemBuilder: (_, index) => PlayerTransferListTile(
          transfer: transfers![index],
        ),
        separatorBuilder: (_, __) => const BalunSeperator(),
      );
}
