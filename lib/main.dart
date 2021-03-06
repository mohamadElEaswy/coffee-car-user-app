import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mk/l10n/l10n.dart';
import 'package:mk/src/core/bloc/cubit/cubit.dart';
import 'package:mk/src/core/bloc/states/states.dart';
import 'package:mk/src/core/navigation/navigation_methods.dart';
import 'package:mk/src/services/remote/firebase/auth.dart';
import 'package:mk/src/services/remote/firebase/database.dart';
import 'package:mk/src/ui/pages/home/home_page.dart';
import 'package:mk/src/ui/pages/sign_in_with_email/sign_in_with_email_screen.dart';
import 'package:mk/src/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'observation.dart';
import 'provider/locale_provider.dart';
import 'src/database/local/local_services.dart';

late String initialRoute;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Firebase.app();
  AuthBase auth = Auth();

  if (auth.currentUser == null) {
    initialRoute = SignInWithEmailAndPhone.route;
  } else {
    initialRoute = Home.route;
  }

  await LocalDBServices.init();
  BlocOverrides.runZoned(
        () =>runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
  runApp(MyApp(currentUser: auth.currentUser));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.currentUser}) : super(key: key);
  static const String title = 'coffee car';

  final User? currentUser;
  @override
  Widget build(BuildContext context) {
    // final Database database = Provider.of<FirestoreDatabase>(context);
    // database.getUser(currentUser!.uid);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
            create: (BuildContext context) => AppCubit()..myLocation()..getFavourites()..getCart()),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, index) {},
        builder: (context, index) {
          return MultiProvider(
            // create: (context) => LocaleProvider(),<LocaleProvider>
            providers: [
              ChangeNotifierProvider<LocaleProvider>(
                  create: (context) => LocaleProvider()),
              Provider<AuthBase>(create: (context) => Auth()),
              Provider<Database>(create: (context) => FirestoreDatabase()),
            ],
            builder: (BuildContext context, child) {
              final LocaleProvider provider =
                  Provider.of<LocaleProvider>(context);
              return MaterialApp(
                title: title,
                theme: AppTheme.lightTheme,
                onGenerateRoute: RouteMethods.generateRoutes,
                initialRoute: initialRoute,
                locale: provider.locale,
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
              );
            },
          );
        },
      ),
    );
  }
}
