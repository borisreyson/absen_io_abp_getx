import 'package:flutter/material.dart';

class LoadingAbp extends StatefulWidget {
  const LoadingAbp({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingAbp> createState() => _LoadingAbpState();
}

class _LoadingAbpState extends State<LoadingAbp> with TickerProviderStateMixin {

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 1), vsync: this)
        ..repeat(reverse: true);
  
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ScaleTransition(
        scale: _animation,
        child: Card(
          elevation: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/abp_60x60.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
