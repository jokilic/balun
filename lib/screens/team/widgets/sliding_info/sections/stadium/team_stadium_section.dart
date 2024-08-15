import 'package:flutter/material.dart';

import '../../../../../../models/teams/venue/venue.dart';
import '../../../../../../theme/theme.dart';
import '../../../../../../widgets/balun_image.dart';

class TeamStadiumSection extends StatelessWidget {
  final Venue? stadium;

  const TeamStadiumSection({
    required this.stadium,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            ///
            /// NAME & CAPACITY
            ///
            if (stadium?.name != null || stadium?.capacity != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///
                  /// NAME
                  ///
                  if (stadium?.name != null)
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: context.textStyles.matchInfoSectionTitle,
                          ),
                          Text(
                            stadium!.name!,
                            style: context.textStyles.matchInfoSectionText,
                          ),
                        ],
                      ),
                    ),

                  ///
                  /// CAPACITY
                  ///
                  if (stadium?.capacity != null)
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Capacity',
                            style: context.textStyles.matchInfoSectionTitle,
                          ),
                          Text(
                            '${stadium!.capacity!}',
                            style: context.textStyles.matchInfoSectionText,
                          ),
                        ],
                      ),
                    ),
                ],
              ),

            const SizedBox(height: 24),

            ///
            /// ADDRESS & CITY
            ///
            if (stadium?.address != null || stadium?.city != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///
                  /// ADDRESS
                  ///
                  if (stadium?.address != null)
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: context.textStyles.matchInfoSectionTitle,
                          ),
                          Text(
                            stadium!.address!,
                            style: context.textStyles.matchInfoSectionText,
                          ),
                        ],
                      ),
                    ),

                  ///
                  /// CITY
                  ///
                  if (stadium?.city != null)
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'City',
                            style: context.textStyles.matchInfoSectionTitle,
                          ),
                          Text(
                            stadium!.city!,
                            style: context.textStyles.matchInfoSectionText,
                          ),
                        ],
                      ),
                    ),
                ],
              ),

            ///
            /// IMAGE
            ///
            if (stadium?.image != null) ...[
              const SizedBox(height: 32),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: BalunImage(
                  imageUrl: stadium!.image!,
                  height: 184,
                ),
              ),
            ],
          ],
        ),
      );
}
