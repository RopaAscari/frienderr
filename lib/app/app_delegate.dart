import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frienderr/core/themes/themes.dart';
import 'package:frienderr/core/constants/constants.dart';
import 'package:frienderr/core/injection/injection.dart';
import 'package:frienderr/features/presentation/blocs/user/user_bloc.dart';
import 'package:frienderr/features/presentation/navigation/app_router.dart';
import 'package:frienderr/features/presentation/blocs/theme/theme_bloc.dart';
import 'package:frienderr/features/presentation/blocs/authenticate/authenticate_bloc.dart';

class AppDelegate extends StatefulWidget {
  final UserBloc userBloc;
  final ThemeBloc themeBloc;
  final AuthenticationBloc authenticationBloc;

  AppDelegate({
    Key? key,
    required this.userBloc,
    required this.themeBloc,
    required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<AppDelegate> createState() => AppDelegateState();
}

class AppDelegateState extends State<AppDelegate> {
  AppRouter get _appRouter => getIt<AppRouter>();
  AuthenticationBloc get authenticationBloc => widget.authenticationBloc;

  @override
  void dispose() {
    super.dispose();
  }

  ThemeData determineTheme(BuildContext context) {
    final String theme =
        BlocProvider.of<ThemeBloc>(context, listen: true).state.theme;
    if (theme == Constants.darkTheme) {
      return appThemeData[AppTheme.Dark]!;
    }
    return appThemeData[AppTheme.Light]!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: Constants.appName,
        theme: determineTheme(context),
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser:
            _appRouter.defaultRouteParser(includePrefixMatches: true));
  }
}
