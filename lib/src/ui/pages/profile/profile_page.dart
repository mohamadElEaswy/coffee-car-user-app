import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:mk/src/core/navigation/navigation_methods.dart';
import 'package:mk/src/ui/pages/profile/account_info.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/sign_in_with_email_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/bloc/cubit/cubit.dart';
import '../../../services/remote/firebase/auth.dart';
import '../../widgets/exceptions.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  static const String route = '/profile';
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();

    } catch (e) {
      // print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure that you want to logout?',
        defaultActionString: 'ok',
        cancelActionText: 'cancel');
    if (didRequestSignOut == true) {
      _signOut(context);
      RouteMethods.navigateTo(context: context, routeName: SignInWithEmailAndPhone.route);
      // AppCubit.get(context).changeScreen(index: 0);
      // print('ok');
    } else {
      // print('cancel');
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        final AppCubit bloc = AppCubit.get(context);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              settingsMenuItem(
                onTap: ()=>RouteMethods.navigateTo(context: context, routeName: AccountInfo.route),
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
              ),
              settingsMenuItem(
                onTap: ()=> _confirmSignOut(context),
                firstIcon: Icons.person_outline_rounded,
                lable: 'Logout',
                lastIcon: FontAwesomeIcons.arrowRight,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget settingsMenuItem({required void Function() onTap,
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
