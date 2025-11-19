import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../models/players/player_response.dart';
import '../../../theme/theme.dart';
import '../../../widgets/widget_size.dart';
import 'main_info/player_main_info.dart';
import 'sliding_info/player_sliding_info.dart';

class PlayerSuccess extends StatefulWidget {
  final PlayerResponse player;

  const PlayerSuccess({
    required this.player,
  });

  @override
  State<PlayerSuccess> createState() => _PlayerSuccessState();
}

class _PlayerSuccessState extends State<PlayerSuccess> {
  late var panelHeight = 100.0;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      ///
      /// TOP CONTENT
      ///
      WidgetSize(
        onChange: (size) => setState(
          () => panelHeight = (MediaQuery.sizeOf(context).height - size.height) - 80,
        ),
        child: PlayerMainInfo(
          player: widget.player,
        ),
      ),

      ///
      /// SLIDING CONTENT
      ///
      SlidingUpPanel(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
        color: context.colors.slidingInfoPanelBackground,
        scrollController: scrollController,
        minHeight: panelHeight,
        maxHeight: MediaQuery.sizeOf(context).height - 144,
        panelBuilder: () => PlayerSlidingInfo(
          player: widget.player,
          scrollController: scrollController,
        ),
      ),
    ],
  );
}
