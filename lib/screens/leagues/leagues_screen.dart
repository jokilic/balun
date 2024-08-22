import 'package:flutter/material.dart';

class LeaguesScreen extends StatelessWidget {
  final String country;

  const LeaguesScreen({
    required this.country,
    required super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: Colors.green,
        ),
      );
}
