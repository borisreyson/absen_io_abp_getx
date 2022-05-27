import 'dart:async';
import 'package:face_id_plus/absensi/landing/intro.dart';
import 'package:flutter/material.dart';
class AnimatedLoading extends StatefulWidget {
  const AnimatedLoading({Key? key}) : super(key: key);

  @override
  State<AnimatedLoading> createState() => _AnimatedLoadingState();
}

class _AnimatedLoadingState extends State<AnimatedLoading> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>
      const SliderIntro()
    )));
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      Center(
        child: ScaleTransition(
          scale: _animation,
          child: Card(
            elevation: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/images/abp_60x60.png",fit: BoxFit.fill,),
              ),
            )
            ,),
        ),
      )
    );
  }
}
