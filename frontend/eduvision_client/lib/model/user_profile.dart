import 'package:flutter/material.dart';


class UserProfile {
  final String id;
  final String email;
  final String? role;
  final String name;
  final String? idClass;
  final String? occupation;


  UserProfile({required this.id, required this.email, this.role, required this.name, this.idClass, this.occupation});
  

}