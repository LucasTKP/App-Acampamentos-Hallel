import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:acamps_canaa/ui/profile/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final ProfileController controller;
  const Header({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  controller.updateImage();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[300],
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: controller.urlImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(color: ThemeColors.primaryColor),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/jesus.jpg',
                            width: 120,
                            height: 120,
                          ),
                        ),
                        
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            height: 30,
                            child: const Center(
                              child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
