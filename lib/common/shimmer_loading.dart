
import 'package:flutter/material.dart';

class CustomShimmer extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const CustomShimmer({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 0.0,
  }) : super(key: key);

  @override
  CustomShimmerState createState() => CustomShimmerState();
}

class CustomShimmerState extends State<CustomShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _gradientPosition = Tween<double>(begin: -1.0, end: 2.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade50,
              Colors.grey.shade200,
            ],
            stops: const [0.0, 0.5, 1.0],
            begin: FractionalOffset(_gradientPosition.value, 0.0),
            end: FractionalOffset(2.0 + _gradientPosition.value, 0.0),
          ),
        ),
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double gradientTranslation(double begin, double end) {
    return (begin + (end - begin) * _gradientPosition.value + 1.0) / 3.0 * widget.width;
  }
}
