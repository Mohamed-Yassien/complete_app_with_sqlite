import 'package:dog/providers/dogs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _ageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Dog',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'name',
              ),
              controller: _nameController,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'age',
              ),
              controller: _ageController,
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                Provider.of<DogsProvider>(context, listen: false).addDog(
                  _nameController.text,
                  int.parse(_ageController.text),
                );
                Navigator.pop(context);
              },
              child: Text('add'),
            ),
          ],
        ),
      ),
    );
  }
}
