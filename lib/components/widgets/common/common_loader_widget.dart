import 'package:flutter/material.dart';

class CommonLoaderWidget extends StatelessWidget {
  const CommonLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:
          SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),
    );
  }
}
