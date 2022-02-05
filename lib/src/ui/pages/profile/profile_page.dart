import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  static const String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          settingsMenuItem(
            onTap: () {},
            firstIcon: Icons.person_outline_rounded,
            lable: 'Account info',
            lastIcon: FontAwesomeIcons.arrowRight,
          ),
          settingsMenuItem(
            onTap: () {},
            firstIcon: Icons.person_outline_rounded,
            lable: 'Change Email',
            lastIcon: FontAwesomeIcons.arrowRight,
          ),
          settingsMenuItem(
            onTap: () {},
            firstIcon: Icons.person_outline_rounded,
            lable: 'Change password',
            lastIcon: FontAwesomeIcons.arrowRight,
          ),
          settingsMenuItem(
            onTap: () {},
            firstIcon: Icons.person_outline_rounded,
            lable: 'Language',
            lastIcon: FontAwesomeIcons.arrowRight,
          ),settingsMenuItem(
            onTap: () {},
            firstIcon: Icons.person_outline_rounded,
            lable: 'Logout',
            lastIcon: FontAwesomeIcons.arrowRight,
          ),
        ],
      ),
    );
  }

  Widget settingsMenuItem(
          {required void Function() onTap,
          required IconData firstIcon,
          required String lable,
          required IconData lastIcon}) =>
      InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: Row(
            children: [
              Icon(firstIcon),
              const SizedBox(
                width: 20,
              ),
              Text(lable),
              const Spacer(),
              Icon(lastIcon),
            ],
          ),
        ),
      );
}
