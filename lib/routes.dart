// GoRouter configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_storage/main.dart';
import 'package:local_storage/second_screen.dart';

router() => GoRouter(
  // initialLocation: '/onboarding',
  errorPageBuilder: (context, state) => MaterialPage(
    child: Scaffold(
      body: Center(child: Text('Sorry, can not find this page \n 404')),
    ),
  ),
  redirect: (context, state) async {
    // if (state.subloc == '/onboarding') {
    //   return '/onboarding';
    // }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(title: 'Flutter Demo Home Page'),
      routes: [
        GoRoute(
          name: 'secondScreen',
          path: '/second_route',
          // reedi
          builder: (context, state) {
            // final data = state.extra as Map<String, dynamic>?;
            // print(state.fullPath);
            // final data = state.uri.queryParameters['data'];
            return SecondScreen(data: '');
          },
          routes: [
          ]
        ),
      ],
    ),
  ],
);
