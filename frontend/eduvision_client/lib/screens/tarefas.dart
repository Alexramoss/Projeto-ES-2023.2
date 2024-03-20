import 'package:flutter/material.dart';

class handleTasksScreen extends StatefulWidget {
  @override
  _handleTasksScreenState createState() => _handleTasksScreenState();
}

class _handleTasksScreenState extends State<handleTasksScreen> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas da turma'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Item ${index + 1}'),
              subtitle: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'TextField 1'),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(labelText: 'TextField 2'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Implement edit functionality
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implement delete functionality
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add functionality
          setState(() {
            items.add('New Item');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: handleTasksScreen(),
  ));
}
