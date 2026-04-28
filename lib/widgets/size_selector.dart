import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  const SizeSelector({super.key, required this.sizes});
  final List<int> sizes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: sizes.map((size) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, size);
            },
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(size.toString()),
            ),
          );
        }).toList(),
      ),
    );
  }
}
