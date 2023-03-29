import 'package:flutter/material.dart';

class FormatText extends StatelessWidget {
  const FormatText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Text("Format"),
          trailing: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.cancel_outlined)),
        )
      ],
    );
  }
}
