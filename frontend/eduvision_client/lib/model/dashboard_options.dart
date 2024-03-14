import 'package:flutter/material.dart';

// Define a class to represent a dashboard menu option
class DashboardOption {
  final IconData icon;
  final String title;

  DashboardOption({required this.icon, required this.title});
}

class StudentsDashboardItems {
  List<DashboardOption> presetOptions = [
    DashboardOption(icon: Icons.school, title: 'Meu curso'),
    DashboardOption(icon: Icons.attach_money, title: 'Financeiro'),
    DashboardOption(icon: Icons.calendar_month, title: 'Eventos'),
    // Add more preset options as needed
  ];

}

class StaffDashboardItems {
  List<DashboardOption> presetOptions = [
    DashboardOption(icon: Icons.school, title: 'Adicionar turma'),
        DashboardOption(icon: Icons.class_, title: 'Adicionar professor'),

    DashboardOption(icon: Icons.person_outlined, title: 'Adicionar aluno'),
    DashboardOption(icon: Icons.calendar_month, title: 'Adicionar evento'),
    DashboardOption(icon: Icons.school, title: 'Editar turma'),
    DashboardOption(icon: Icons.class_, title: 'Editar professor'),

    DashboardOption(icon: Icons.person_outlined, title: 'Editar aluno'),
    DashboardOption(icon: Icons.calendar_month, title: 'Editar evento'),


  ];
}

class ClassDashboardItems {
  List<DashboardOption> presetOptions = [
    DashboardOption(icon: Icons.school, title: 'Minhas notas'),
    DashboardOption(icon: Icons.person_outlined, title: 'Professores')


  ];
}
