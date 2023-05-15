import 'package:amazon_clone/constants/golabal_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderIndicator extends StatelessWidget {
  const LoaderIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SpinKitChasingDots(
      color: GlobalVariables.secondaryColor,
    ));
  }
}
