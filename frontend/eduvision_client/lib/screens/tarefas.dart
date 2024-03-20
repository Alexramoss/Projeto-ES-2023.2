// import 'package:flutter/material.dart';

// class HandleTasksScreen extends StatefulWidget {
//   @override
//   _HandleTasksScreenState createState() => _HandleTasksScreenState();
// }

// class _HandleTasksScreenState extends State<HandleTasksScreen> {
//   List<String> items = ['Item 1', 'Item 2', 'Item 3'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tarefas da turma'),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Text('Item ${index + 1}'),
//               subtitle: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'TextField 1'),
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(labelText: 'TextField 2'),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.edit),
//                     onPressed: () {
//                       // Implement edit functionality
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       // Implement delete functionality
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Implement add functionality
//           setState(() {
//             items.add('New Item');
//           });
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: HandleTasksScreen(),
//   ));
// }

import 'package:flutter/material.dart';

class HandleTasksScreen extends StatefulWidget {
  @override
  _HandleTasksScreenState createState() => _HandleTasksScreenState();
}

class _HandleTasksScreenState extends State<HandleTasksScreen> {
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
              subtitle: Text('Subtitle for Item ${index + 1}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
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
              onTap: () {
                // Handle tile tap
              },
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
    home: HandleTasksScreen(),
  ));
}
