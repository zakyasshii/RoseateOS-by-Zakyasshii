import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Contacts')),
      body: const Center(child: Text('Business Contacts UI goes here.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Show add contact dialog
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 