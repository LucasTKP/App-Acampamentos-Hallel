import 'package:flutter/material.dart';

class DailyPrayerSkeleton extends StatelessWidget {
  const DailyPrayerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      child: LayoutBuilder(
        builder: (context, contrains) {
          final width = contrains.maxWidth;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAnimation(width: width * 0.9, height: 14),
              const SizedBox(height: 4),
              SkeletonAnimation(width: width * 0.8, height: 14),
              const SizedBox(height: 4),
              SkeletonAnimation(width: width * 0.6, height: 14),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SkeletonAnimation(width: 20, height: 20, shape: BoxShape.circle),
                  SizedBox(width: 8),
                  SkeletonAnimation(width: 120, height: 14),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class SkeletonAnimation extends StatefulWidget {
  final double width;
  final double height;
  final BoxShape shape;
  final EdgeInsetsGeometry? margin;

  const SkeletonAnimation({
    super.key,
    required this.width,
    required this.height,
    this.shape = BoxShape.rectangle,
    this.margin,
  });

  @override
  SkeletonAnimationState createState() => SkeletonAnimationState();
}

class SkeletonAnimationState extends State<SkeletonAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = ColorTween(
      begin: Colors.grey[300],
      end: Colors.grey[100],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            color: _animation.value,
            shape: widget.shape,
            borderRadius: widget.shape == BoxShape.rectangle ? BorderRadius.circular(4) : null,
          ),
        );
      },
    );
  }
}
