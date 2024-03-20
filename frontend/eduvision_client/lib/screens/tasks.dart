

import 'package:eduvision_client/model/board.dart';
import 'package:eduvision_client/services/tasks_api_service.dart';
import 'package:flutter/material.dart';

class HandleTasksScreen extends StatefulWidget {

    List<BoardItemObject> items;
    String idClass;


    HandleTasksScreen({required this.items, required this.idClass});

  @override
  _HandleTasksScreenState createState() => _HandleTasksScreenState(items: items, idClass: idClass);
}


class _HandleTasksScreenState extends State<HandleTasksScreen> {
  List<BoardItemObject> items;
  String idClass;

  _HandleTasksScreenState({required this.items, required this.idClass});

  // Method to edit a task
  void _editTask(BoardItemObject task) async {

    String result = await TaskAPIService().editTask(task.id!, task.toJson());
    print(result); 
  }

  // Method to delete a task
  void _deleteTask(BoardItemObject task) async {
   
    String result = await TaskAPIService().deleteTask(task.id!);
    getTasksByClass(idClass);
    print(result); 
  }

  Future<void> getTasksByClass(String? classId) async {
    try {
      
      if (classId == null) {
        return;
      }
      items = await TaskAPIService().getTasksByClass(classId!);
      setState(() {}); 

    } catch (error) {
      throw 'Erro: $error';
    }
  }

  // Method to show dialog for adding a new task
  void _showAddTaskDialog() {

  showDialog(
  context: context,
  builder: (BuildContext context) {
    // Controllers for text fields
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController explanationTitleController = TextEditingController();
    TextEditingController explanationController = TextEditingController();

    return AlertDialog(
      title: Text('Adicionar tarefa'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Digite o título da tarefa',
            ),
          ),
          SizedBox(height: 4),

          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: 'Digite a descrição da tarefa',
            ),
          ),
          SizedBox(height: 4),

          TextField(
            controller: explanationTitleController,
            decoration: InputDecoration(
              hintText: 'Digite o título da explicação',
            ),
          ),
           SizedBox(height: 4),

          TextField(
            controller: explanationController,
            decoration: InputDecoration(
              hintText: 'Digite a explicação',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {

            String taskTitle = titleController.text;
            String taskDescription = descriptionController.text;
            String explanationTitle = explanationTitleController.text;
            String explanation = explanationController.text;
            print(taskTitle);
                        print(taskDescription);

            // Create a new task object
            BoardItemObject newTask = BoardItemObject(
              idClass: idClass,
              title: taskTitle,
              description: taskDescription,
              explanationTitle: explanationTitle,
              explanationDescription: explanation,
              status: "a fazer"
            );

           
            print(newTask.toJson());
            TaskAPIService().addTask(newTask.toJson()).then((result) {

              print(result); // Print the result for debugging
              getTasksByClass(idClass);
              Navigator.pop(context); // Close the dialog
            }).catchError((error) {
              print('Error adding task: $error'); // Print the error for debugging
            });
          },
          child: Text('Add'),
        ),
      ],
    );
  },
);

  }


  void _showTaskDetailsDialog(BoardItemObject item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(item.title ?? ''),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Descrição: ${item.description ?? ''}'),
              Text('${item.explanationTitle ?? ''}'),
              Text('Explicação: ${item.explanationDescription ?? ''}'),
              // Add more fields as needed
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
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
              title: Text('${items[index].title }'),
              subtitle: Text('${items[index].explanationTitle}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editTask(items[index]); // Call edit task method
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteTask(items[index]); // Call delete task method
                    },
                  ),
                ],
              ),
              onTap: () {
                _showTaskDetailsDialog(items[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Show the add task dialog
        child: Icon(Icons.add),
      ),
    );
  }
}
