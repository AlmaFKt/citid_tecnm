import 'package:citid_tecnm/componentes/Theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Widget? icon;

  const MyButton({Key? key, required this.text, required this.onTap, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(maxWidth: 230),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 70.0),
        decoration: BoxDecoration(
          color: azulITZ,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: 3),
              ],
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
