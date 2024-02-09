
import 'package:flutter/material.dart';

class DeatilsWidget extends StatelessWidget {
  const DeatilsWidget({
    super.key,
    required this.dheight,
    required this.value,
    required this.title,
  });

  final double dheight;
  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: dheight / 10,
      color: Colors.deepPurple[200],
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
          ],
        ),
      ),
    );
  }
}
