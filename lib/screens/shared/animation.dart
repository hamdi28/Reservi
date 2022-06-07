import 'package:flutter/material.dart';

class ImageRotate extends StatefulWidget {
  final Widget child;
  const ImageRotate({required this.child});
  @override
  _ImageRotateState createState() => _ImageRotateState();
}

class _ImageRotateState extends State<ImageRotate>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.centerRight,
      //color: Colors.white,
      child: AnimatedBuilder(
        animation: animationController,
        /* child: const SizedBox(
          height: 150.0,
          width: 150.0,
          // child: Image.asset('images/batmanlogo.png'),
        ),*/
        builder: (BuildContext context, _widget) {
          return Transform.rotate(
            angle: animationController.value * 6.3,
            child: widget.child,
          );
        },
      ),
    );
  }
}
