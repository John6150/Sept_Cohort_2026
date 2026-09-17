import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:local_storage/routes.dart';
import 'package:local_storage/second_screen.dart';
import 'package:local_storage/third_screen.dart';
import 'package:local_storage/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentCodes {
  String? code;
  String? name;

  StudentCodes({this.code, this.name});

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name};
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: true ? '/' : '/onboarding',
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            name: 'home',
            redirect: (_, _) async {},
            routes: [
              GoRoute(
                path: '/secondRoute/:name',
                name: 'second',
                redirect: (context, state) async {},
                builder: (context, state) {
                  // final data = state.extra as Map<String, dynamic>;
                  // final data = state.extra as String;
                  print('this is the Authoruty${state.fullPath}');
                  final data = state.pathParameters['name'];
                  // final data = state.pathParameters['name'];
                  // final data = state.uri.queryParameters['name'];
                  // String name = data;
                  return SecondScreen(data: data ?? 'No Data Received');
                },
                routes: [
                  GoRoute(
                    path: '/thirdRoute',
                    name: 'third',
                    builder: (context, state) => ThirdScreen(),
                  ),
                ],
              ),
            ],
            builder: (context, GoRouterState state) {
              return MyHomePage(title: 'Fluttrr Demo Home Page');
            },
          ),
          GoRoute(
            path: '/onboarding',
            builder: (context, state) => Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.amber,
              child: Text('This is onboarding'),
            ),
          ),
        ],
      ),
      // routerConfig: router(),
      // routes: {
      //   '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
      //   '/secondRoute': (context) => const SecondScreen(),
      // },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;
  String saved = '';
  StudentCodes? stdFetchedData;
  final _controller = TextEditingController();
  StudentCodes std1 = StudentCodes(code: '001', name: 'John Doe');

  @override
  void initState() {
    super.initState();
    final storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        enforceBiometrics: true,
        biometricPromptTitle: 'Biometric Authentication',
        biometricPromptSubtitle: '',
      ),
      iOptions: IOSOptions(
        accountName: 'my_account',
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );

    // WidgetsBinding.instance.addPostFrameCallback((_) async {});

    // Future.delayed(Duration(seconds: 10), () async {});

    Future.microtask(() async {
      try {
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        final FlutterSecureStorage storage = FlutterSecureStorage(
          aOptions: AndroidOptions(
            enforceBiometrics: true,
            biometricPromptTitle: 'Biometric Authentication',
            biometricPromptSubtitle:
                'Please authenticate to access secure storage',
          ),
        );

        String? savedData = await storage.read(key: 'stdData');
        stdFetchedData = savedData != null
            ? StudentCodes(
                code: jsonDecode(savedData)['code'],
                name: jsonDecode(savedData)['name'],
              )
            : null;
        // // String? result = await prefs.getString('text');
        // print(result.runtimeType);
        // setState(() {
        //   saved = jsonDecode(result ?? '')['info'] ?? '';
        // });

        // String? savedData = await storage.read(key: 'key');
        setState(() {
          saved = savedData ?? 'Sorry, nothing to show';
        });
      } catch (e) {
        print(e);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              onChanged: (value) => setState(() {}),
            ),
            Text(stdFetchedData?.name ?? 'No data fetched'),
            // Text(saved),
            SizedBox(height: 50),
            Text(counter.toString()),
            // Text(saved),
            SizedBox(height: 50),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  _controller.text.isEmpty
                      ? Colors.purple.withValues(alpha: 0.05)
                      : Colors.purple,
                ),
              ),
              onPressed: () {
                _controller.text.isEmpty
                    ? null
                    : context.push(
                        '/secondRoute/${_controller.text}',
                        // '/secondRoute?name=${_controller.text}',

                        // extra: _controller.text,
                      );
                // Navigator.pushNamed(context, '/secondRoute'); // Named Routing
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SecondScreen(),
                //   ), // Unamed Routing
                // );
              },
              child: Text(
                'Go to Second Screen',
                style: TextStyle(
                  color: _controller.text.isEmpty
                      ? Colors.purple
                      : Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.canPop() ? context.pop() : null;
              },
              child: Text(''),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              ref.read(counterProvider.notifier).state++;
            },
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              try {
                // final SharedPreferences prefs =
                //     await SharedPreferences.getInstance();
                // await prefs.remove('text');
                final storage = FlutterSecureStorage(
                  aOptions: AndroidOptions(
                    enforceBiometrics: true,
                    biometricPromptTitle: 'Biometric Authentication',
                    biometricPromptSubtitle:
                        'Please authenticate to access secure storage',
                  ),
                );
                await storage.delete(key: 'stdData');
                print('Deleted successfully');
                setState(() {
                  // saved = '';
                  stdFetchedData = null;
                });
              } catch (e) {
                print(e);
              }
              //   context.push('/second_route?data=${_controller.text}');
            },
            tooltip: 'Delete',
            child: const Icon(Icons.delete),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              try {
                // final SharedPreferences prefs =
                //     await SharedPreferences.getInstance();
                // final Map<String, dynamic> textToSave = {
                //   "info": _controller.text,
                // };
                // await prefs.setString('text', jsonEncode(textToSave));
                // _controller.clear();
                setState(() {
                  // saved = _controller.text;
                });
              } catch (e) {
                print(e);
              }
              // Navigator.pushNamed(
              //   context,
              //   '/secondRoute',
              //   arguments: {'data': _controller.text},
              // );

              // context.push(
              //   '/second_route?data=${_controller.text}',
              //   // extra: {'data': _controller.text}
              // );
              // context.pop();

              std1.name = _controller.text;

              // // print(_controller.text);
              final storage = FlutterSecureStorage(
                aOptions: AndroidOptions(
                  enforceBiometrics: true,
                  biometricPromptTitle: 'Biometric Authentication',
                  biometricPromptSubtitle:
                      'Please authenticate to access secure storage',
                ),
                iOptions: IOSOptions(
                  // accessibility: KeychainAccessibility.,
                ),
              );
              try {
                await storage.write(
                  key: 'stdData',
                  value: jsonEncode(std1.toJson()),
                );
                print('Saved successfully');
              } catch (e) {
                print(e);
              }
            },
            tooltip: 'Save',
            child: const Icon(Icons.save),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
