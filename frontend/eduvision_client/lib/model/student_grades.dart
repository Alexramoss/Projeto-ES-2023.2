import 'package:flutter/material.dart';

class StudentGrades {
  final String rastud;
  final String? linguaPortuguesa;
  final String? artes;
  final String? educacaoFisica;
  final String? matematica;
  final String? biologia;
  final String? fisica;
  final String? quimica;
  final String? historia;
  final String? geografia;
  final String? filosofia; // Add property for 'FILOSOFIA'
  final String? sociologia;
  final String? eletiva;
  final String? resultado;

  StudentGrades(
    {required this.rastud,
    required this.linguaPortuguesa,
    this.artes,
    this.educacaoFisica,
    this.matematica,
    this.biologia,
    this.fisica,
    this.quimica,
    this.historia,
    this.geografia,
    this.filosofia,
    this.sociologia,
    this.eletiva,
    required this.resultado}
  );

  factory StudentGrades.fromJson(Map<String, dynamic> json) {
  return StudentGrades(
    rastud: json['RASTUD'] ?? '',
    linguaPortuguesa: json['LINGUA_PORTUGUESA']?.toString() ?? '', // Convert to String if not already a String
    artes: json['ARTES']?.toString() ?? '', // Convert to String if not already a String
    educacaoFisica: json['EDUCACAO_FISICA']?.toString() ?? '', // Convert to String if not already a String
    matematica: json['MATEMATICA']?.toString() ?? '', // Convert to String if not already a String
    biologia: json['BIOLOGIA']?.toString() ?? '', // Convert to String if not already a String
    fisica: json['FISICA']?.toString() ?? '', // Convert to String if not already a String
    quimica: json['QUIMICA']?.toString() ?? '', // Convert to String if not already a String
    historia: json['HISTORIA']?.toString() ?? '', // Convert to String if not already a String
    geografia: json['GEOGRAFIA']?.toString() ?? '', // Convert to String if not already a String
    filosofia: json['FILOSOFIA']?.toString() ?? '',
    sociologia: json['SOCIOLOGIA']?.toString() ?? '', // Convert to String if not already a String
    eletiva: json['ELETIVA']?.toString() ?? '', // Convert to String if not already a String
    resultado: json['RESULTADO']?.toString() ?? '', // Convert to String if not already a String
  );
}


  Map<String, dynamic> toJson() {
    return {
      'RASTUD': rastud,
      'LINGUA_PORTUGUESA': linguaPortuguesa,
      'ARTES': artes,
      'EDUCACAO_FISICA': educacaoFisica,
      'MATEMATICA': matematica,
      'BIOLOGIA': biologia,
      'FISICA': fisica,
      'QUIMICA': quimica,
      'HISTORIA': historia,
      'GEOGRAFIA': geografia,
      'FILOSOFIA' : filosofia,
      'SOCIOLOGIA': sociologia,
      'ELETIVA': eletiva,
      'RESULTADO': resultado,
    };
  }
}
