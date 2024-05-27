import 'package:flutter/material.dart';

import '../constants/Theme.dart';

class TableCellSettings extends StatelessWidget {
  final String title;
  final  onTap;
  const TableCellSettings({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: ArgonColors.text)),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios,
                  color: ArgonColors.text, size: 14),
            )
          ],
        ),
      ),
    );
  }
}
