import 'dart:math';

import 'package:dog/helpers/db_helper.dart';
import 'package:dog/models/dog.dart';
import 'package:flutter/foundation.dart';

class DogsProvider with ChangeNotifier {
  List<Dog> _dogs = [];

  List<Dog> get dogs => [..._dogs];

  addDog(String name, int age) async {
    Random random = Random();
    int id = random.nextInt(50);
    Dog dog = Dog(
      id: id,
      name: name,
      age: age,
    );
    _dogs.add(dog);
    notifyListeners();
    await DatabaseHelper.insertDog(dog);
  }

  fetchAllDogs() async {
    final allDogs = await DatabaseHelper.getDogs();

    _dogs = allDogs
        .map(
          (e) => Dog(
            id: e.id,
            name: e.name,
            age: e.age,
          ),
        )
        .toList();
    notifyListeners();
  }

  deleteDog(int id) async {
    await DatabaseHelper.deleteDog(id);
    fetchAllDogs();
    notifyListeners();
  }

  updateDog(Dog dog) async {
    await DatabaseHelper.updateDog(dog);
    fetchAllDogs();
    notifyListeners();
  }
}
