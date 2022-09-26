import 'package:flutter/material.dart';

class AddContact extends StatelessWidget {
  @override
  Widget build(BuildContext context)=> Scaffold(
    appBar: AppBar(
      title: const Text('Add Contact'),
      centerTitle: true,
    ),
    body: ListView(padding: const EdgeInsets.all(16),children: [
      const Text('Create',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),),
      const SizedBox(height: 25),
      ElevatedButton.icon(
        onPressed: (){},
        icon: const Icon(Icons.add_box),
        label: const Text('Add Photo',
      ),),
      const SizedBox(height: 25),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Name',border: OutlineInputBorder()),
      ),
      const SizedBox(height: 25),
       TextFormField(
        decoration: const InputDecoration(labelText: 'Last Name',border: OutlineInputBorder()),
      ),
      const SizedBox(height: 25),
       TextFormField(
        keyboardType: TextInputType.phone,decoration: const InputDecoration(labelText: 'Number +XXX',border: OutlineInputBorder()),
      ),
      const SizedBox(height: 25),
      TextFormField(
        minLines: 5,maxLines: 10,decoration: const InputDecoration(labelText: 'Notes',border: OutlineInputBorder()),
      ),
      const SizedBox(height: 45),
      ElevatedButton.icon(
        onPressed: (){},
        icon: const Icon(Icons.save),
        label: const Text('Save',
      ),),
    ],) 
  );
}