import 'package:flutter/material.dart';

import '../const.dart';

class BodyComponent extends StatelessWidget {
  const BodyComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("This is appbar"),
            Image.network(url),
            Row(
              children: [
                const Text("This is appbar"),
                Flexible(child: Image.network(url)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
