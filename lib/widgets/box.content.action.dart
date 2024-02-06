import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';

import 'text.dart';

class BoxContentAction extends StatelessWidget {
  const BoxContentAction({
    super.key,
    required this.icon,
    required this.nb,
    required this.onTap,
  });
  final HeroIcons icon;
  final String nb;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [HeroIcon(icon), width5(), TextSmall(nb)],
      ),
    );
  }
}
