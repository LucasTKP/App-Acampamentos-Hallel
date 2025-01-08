import 'package:flutter/material.dart';

class UsersBirthSkeleton extends StatelessWidget {
  const UsersBirthSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonAnimation(
                width: 80,
                height: 80,
                shape: BoxShape.circle,
              ),
              SizedBox(width: 16),
              // Esqueleto dos textos
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonAnimation(width: 120, height: 16),
                    SizedBox(height: 12),
                    SkeletonAnimation(width: 180, height: 12),
                    SizedBox(height: 4),
                    SkeletonAnimation(width: 180, height: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Indicadores de página como esqueleto
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return const SkeletonAnimation(
                width: 12,
                height: 12,
                shape: BoxShape.circle,
                margin: EdgeInsets.symmetric(horizontal: 4),
              );
            }),
          ),
        ],
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
