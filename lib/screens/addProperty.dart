import 'package:flutter/material.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({super.key});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Add Property Screen'),
    );
  }
}
