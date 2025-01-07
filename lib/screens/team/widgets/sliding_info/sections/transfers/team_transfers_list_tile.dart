import 'package:flutter/material.dart';

import '../../../../../../constants.dart';
import '../../../../../../models/transfers/transfer_response.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../util/word_mix.dart';
import '../../../../../../widgets/balun_button.dart';
import 'team_transfer_list_tile.dart';

class TeamTransfersListTile extends StatefulWidget {
  final TransferResponse transfer;

  const TeamTransfersListTile({
    required this.transfer,
  });

  @override
  State<TeamTransfersListTile> createState() => _TeamTransfersListTileState();
}

class _TeamTransfersListTileState extends State<TeamTransfersListTile> {
  var expanded = false;

  void toggleExpanded() => setState(
        () => expanded = !expanded,
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            ///
            /// INFO
            ///
            BalunButton(
              onPressed: toggleExpanded,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        mixOrOriginalWords(widget.transfer.player?.name) ?? '---',
                        style: context.textStyles.leagueTeamsTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///
            /// SEASONS
            ///
            if (widget.transfer.transfers?.isNotEmpty ?? false)
              AnimatedSize(
                duration: BalunConstants.expandDuration,
                curve: Curves.easeIn,
                child: expanded
                    ? ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 8),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.transfer.transfers?.length ?? 0,
                        itemBuilder: (_, index) => TeamTransferListTile(
                          transfer: widget.transfer.transfers![index],
                        ),
                        separatorBuilder: (_, __) => const SizedBox(height: 24),
                      )
                    : const SizedBox.shrink(),
              ),
          ],
        ),
      );
}
