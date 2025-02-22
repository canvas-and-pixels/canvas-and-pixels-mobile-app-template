import 'package:flutter/material.dart';

class AlternateDisplay extends StatelessWidget {
  const AlternateDisplay({
    super.key,
    required this.control,
    this.visible = true,
    this.onTap,
    required this.initialChild,
    required this.finalChild,
  });
  final bool control, visible;
  final Widget? initialChild, finalChild;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: control ? finalChild : initialChild,
        ),
      ),
    );
  }
}
