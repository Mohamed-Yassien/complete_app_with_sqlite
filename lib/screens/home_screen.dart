import 'package:dog/providers/dogs_provider.dart';
import 'package:dog/screens/add_dog_screen.dart';
import 'package:dog/screens/update_dog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddDogScreen(),
                ),
              );
            },
          ),
        ],
        title: Text(
          'Dog Screen',
        ),
      ),
      body: FutureBuilder(
        future:
            Provider.of<DogsProvider>(context, listen: false).fetchAllDogs(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<DogsProvider>(
                    builder: (context, dog, ch) => dog.dogs.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: dog.dogs.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateDogScreen(dog.dogs[index]),
                                  ),
                                );
                              },
                              title: Text(dog.dogs[index].name),
                              subtitle: Text(
                                dog.dogs[index].age.toString(),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  dog.deleteDog(dog.dogs[index].id);
                                },
                              ),
                            ),
                          ),
                    child: Center(
                      child: Text('add some dogs'),
                    ),
                  ),
      ),
    );
  }
}
