import 'package:flutter/widgets.dart';
import 'package:flutter_starter_base_app/src/constants/svg_loader.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});
  @override
  State<StatefulWidget> createState() => _LoadingAnimatioState();
}

class _LoadingAnimatioState extends State<LoadingAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(lowerBound: 0.5, upperBound: 1.3, duration: const Duration(seconds: 1), vsync: this)
        ..repeat(reverse: true);
  late final AnimationController _controller2 =
      AnimationController(lowerBound: 0.5, upperBound: 1.3, duration: const Duration(seconds: 1), vsync: this);
  late final AnimationController _controller3 =
      AnimationController(lowerBound: 0.5, upperBound: 1.3, duration: const Duration(seconds: 1), vsync: this);
  late final AnimationController _controller4 =
      AnimationController(lowerBound: 0.5, upperBound: 1.3, duration: const Duration(seconds: 1), vsync: this);
  listener() {
    if (_controller.value > 0.7) {
      _controller2.repeat(reverse: true);
      _controller.removeListener(listener);
    }
  }

  listener2() {
    if (_controller2.value > 0.7) {
      _controller3.repeat(reverse: true);
      _controller2.removeListener(listener2);
    }
  }

  listener3() {
    if (_controller3.value > 0.7) {
      _controller4.repeat(reverse: true);
      _controller3.removeListener(listener3);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(listener);
    _controller2.addListener(listener2);
    _controller3.addListener(listener3);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext _, child) => Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Transform.scale(
                scale: _controller.value,
                child: Padding(padding: const EdgeInsets.all(8.0), child: SVGLoader().emptyCircleIcon)),
            Transform.scale(
                scale: _controller2.value,
                child: Padding(padding: const EdgeInsets.all(8.0), child: SVGLoader().emptyCircleIcon)),
            Transform.scale(
                scale: _controller3.value,
                child: Padding(padding: const EdgeInsets.all(8.0), child: SVGLoader().emptyCircleIcon)),
            Transform.scale(
                scale: _controller4.value,
                child: Padding(padding: const EdgeInsets.all(8.0), child: SVGLoader().emptyCircleIcon)),
          ]));
}
