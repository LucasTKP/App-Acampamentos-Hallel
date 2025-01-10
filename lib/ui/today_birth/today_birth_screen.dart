import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/today_birth/today_birth_controller.dart';
import 'package:app_acampamentos_hallel/ui/today_birth/widgets/users_birth_loading.dart';
import 'package:flutter/material.dart';

class TodayBirthScreen extends StatelessWidget {
  final TodayBirthController controller;
  const TodayBirthScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Aniversariantes',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF535353),
                  ),
                ),
              ],
            ),
            if (controller.state != AsyncState.loading)
              InkWell(
                onTap: () async {
                  await controller.getUsersBirthday();
                },
                child: const Icon(Icons.refresh, color: Color(0xFF535353)),
              )
          ],
        ),
        _buildContent(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (controller.state) {
      case AsyncState.loading:
        return const UsersBirthLoading();

      case AsyncState.error:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ThemeColors.primaryColor,
          ),
          child: const Center(
            child: Text(
              'Erro ao carregar aniversariantes',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );

      case AsyncState.initial:
        final users = controller.todayBirth?.users ?? [];
        if (users.isEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(255, 228, 228, 228),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info, color: ThemeColors.primaryColor),
                SizedBox(height: 8),
                Text(
                  'Hoje não temos nenhum aniversariante',
                  style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ThemeColors.primaryColor,
          ),
          child: PageView.builder(
            controller: controller.pageTodayBirthController,
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.photoUrl),
                          radius: 40,
                          child: Image.network(
                            user.photoUrl,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              'assets/images/jesus.jpg',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.getName(user.name),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Esta fazendo ${controller.getAge(user.dateOfBirth.toDate())} anos, deseje Feliz Aniversário para ele! 🎉',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(users.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: controller.curretPage == index ? 12 : 8,
                        height: controller.curretPage == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: controller.curretPage == index ? Colors.white : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        );
    }
  }
}
