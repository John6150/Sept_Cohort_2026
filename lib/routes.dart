// GoRouter configuration
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_storage/main.dart';
import 'package:local_storage/onboarding.dart';
import 'package:local_storage/second_screen.dart';

GoRouter router(bool ifr) {
  return GoRouter(
    initialLocation: ifr ? '/onboarding' : null,
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
        builder: (context, state) =>
            MyHomePage(title: 'Flutter Demo Home Page'),
        routes: [
          GoRoute(
            name: 'secondScreen',
            path: '/second_route',
            // reedi
            builder: (context, state) {
              // final data = state.extra as Map<String, dynamic>?;
              // print(state.fullPath);
              // final data = state.uri.queryParameters['data'];
              return LayoutBuilder(
                builder: (context, constraint) {
                  return constraint.maxWidth >= 650
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.red,
                          child: Wrap(
                            spacing: 400,
                            runSpacing: 400,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.green,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.white,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.amber,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.black45,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.yellow,
                          child: Wrap(
                            spacing: 400,
                            runSpacing: 400,
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.green,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.white,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.amber,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.black45,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        );
                  //  ) : SecondScreen(data: '');
                },
              );
            },
            routes: [
          ]
        ),
        ],
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) {
          return Onboarding();
        },
      ),
    ],
  );
}
