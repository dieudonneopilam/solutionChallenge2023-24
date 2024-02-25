import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/animation/notfound.json',
            height: 250, fit: BoxFit.cover),
        const TextSmall('Aucun post trouvé')
      ],
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/animation/loading.json',
            height: 250, fit: BoxFit.cover),
      ],
    );
  }
}
