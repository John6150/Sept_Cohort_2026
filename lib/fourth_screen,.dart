import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_storage/SQFlite_class.dart';

class SQFLiteClass extends ConsumerStatefulWidget {
  const SQFLiteClass({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SQFLiteClassState();
}

class _SQFLiteClassState extends ConsumerState<SQFLiteClass> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQFLite DB')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(label: Text('name')),
            ),
            SizedBox(height: 50),
            TextField(
              controller: ageController,
              decoration: InputDecoration(label: Text('age')),
            ),
            SizedBox(height: 50),
            TextField(
              controller: genderController,
              decoration: InputDecoration(label: Text('gender')),
            ),
            SizedBox(height: 50),
            TextButton(
              onPressed: () async {
                // Save data to Phone Storage
                final db = SqfLiteDB();
                await db.insertFn(
                  name: nameController.text,
                  age: int.tryParse(ageController.text) ?? 0,
                  gender: genderController.text,
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
