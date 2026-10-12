import 'package:flutter/material.dart';
import 'students.dart';
import 'routes.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  Future<void> _open(Student s) async {
    await Navigator.of(context).pushNamed(Routes.student, arguments: s);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final s = students[index];
          return ListTile(
            leading: CircleAvatar(child: Text(s.initial)),
            title: Text(s.name),
            subtitle: Text(s.group),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _open(s),
          );
        },
      ),
    );
  }
}
