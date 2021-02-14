import 'package:dog/models/dog.dart';
import 'package:dog/providers/dogs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateDogScreen extends StatelessWidget {
  final Dog dog;

  UpdateDogScreen(this.dog);

  @override
  Widget build(BuildContext context) {
    String name;
    String age;

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'update Dog',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'name',
                ),
                initialValue: dog.name,
                onSaved: (val) {
                  name = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'age',
                ),
                initialValue: dog.age.toString(),
                onSaved: (val) {
                  age = val;
                },
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  formKey.currentState.save();
                  Provider.of<DogsProvider>(context,listen: false).updateDog(
                    Dog(
                      name: name,
                      age: int.parse(age),
                      id: dog.id
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text('add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
