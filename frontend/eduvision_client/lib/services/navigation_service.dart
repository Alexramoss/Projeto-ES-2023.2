import 'package:eduvision_client/screens/class_screen.dart';
import 'package:eduvision_client/screens/create_class_screen.dart';
import 'package:eduvision_client/screens/create_student_screen.dart';
import 'package:eduvision_client/screens/create_system_manager.dart';
import 'package:eduvision_client/screens/grades_screen.dart';
import 'package:eduvision_client/screens/kanban_screen.dart';
import 'package:eduvision_client/screens/select_class.dart';
import 'package:eduvision_client/screens/tarefas.dart';
import "package:flutter/material.dart";

class NavigatorService {
  static Future<void> navigateToScreen(BuildContext context, String title) async {
    // Implement navigation logic here
    switch (title) {
      case 'Meu curso':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClassDashboardScreen(fullName: "Maria Vitoria")),
        );
        break;
      case 'Minhas notas':
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => 
          GradesScreen()
      ),
        );
      case 'Adicionar turma':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateClassScreen()),
        );
        break;
      case 'Adicionar aluno':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddStudentScreen()),
        );
        break;
        case 'Ver quadro':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KanbanBoard()),
        );
        break;
        case 'Adicionar administrador':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddManagerScreen()),
        );
        break;
        case 'Tarefas da turma':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectClassScreen()),
        );
        break;
      // Add more navigation options as needed
      default:
        // Navigate to a default screen or handle invalid options
        break;
    }
  }
}
