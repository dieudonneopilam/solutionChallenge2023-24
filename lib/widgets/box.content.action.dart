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
    this.colorIcon = Colors.grey,
  });
  final HeroIcons icon;
  final String nb;
  final VoidCallback onTap;
  final Color colorIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          HeroIcon(
            icon,
            color: colorIcon,
          ),
          width5(),
          TextSmall(nb, color: colorIcon)
        ],
      ),
    );
  }
}
