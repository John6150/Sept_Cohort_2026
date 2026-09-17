import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_storage/variables.dart';

class SecondScreen extends StatefulWidget {
  final String data;
  const SecondScreen({super.key, required this.data});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    // final data =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(title: const Text('Second Screen')),
      floatingActionButton: Consumer(
        builder: (context, ref, _) => FloatingActionButton(
          onPressed: () async {
            ref.read(counterProvider.notifier).state--;
          },
          tooltip: 'Subtract',
          child: const Icon(Icons.minimize),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.data),

            Consumer(
              builder: (context, WidgetRef ref, _) =>
                  Text(ref.watch(counterProvider).toString()),
            ),

            TextButton(
              onPressed: () {
                context.push('/secondRoute/thirdRoute');
              },
              child: Text("Go to Third Screen"),
            ),
            TextButton(
              onPressed: () {
                context.go('/');
              },
              child: Text("Go Home"),
            ),
          ],
        ),
      ),
    );
  }
}
