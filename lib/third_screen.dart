import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThirdScreen extends StatefulWidget {
  final String? data;
  const ThirdScreen({super.key, this.data});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    // final data =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Third Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.data ?? 'No data received'),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                // context.pop();
                context.canPop() ? context.pop() : null;
                // Navigator.pop(context);
              },
              child: Text(widget.data ?? 'Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
