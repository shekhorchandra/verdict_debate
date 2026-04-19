import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArenaController extends GetxController {
  var selectedFilter = 1.obs;

  // EXPLICIT TYPE: List<Map<String, dynamic>>
  final List<Map<String, dynamic>> filters = [
    {
      "label": "Following",
      "icon": Icons.person_add_alt_1_outlined
    },
    {
      "label": "Heating Up",
      "icon": Icons.local_fire_department_outlined
    },
    {
      "label": "Top Debates",
      "icon": Icons.trending_up
    },
  ];

  final List<Map<String, dynamic>> trendingDebates = [
    {
      "views": "125.7k",
      "time": "30 min",
      "p1": {"name": "jamie_vardy", "votes": 39, "isWinner": true, "img": "https://i.pravatar.cc/150?u=1"},
      "p2": {"name": "emily_watson11", "votes": 61, "isWinner": false, "img": "https://i.pravatar.cc/150?u=2"},
    },
    {
      "views": "125.7k",
      "time": "30 min",
      "p1": {"name": "jamie_vardy", "votes": 39, "isWinner": false, "img": "https://i.pravatar.cc/150?u=3"},
      "p2": {"name": "emily_watson11", "votes": 61, "isWinner": true, "img": "https://i.pravatar.cc/150?u=4"},
    },
  ];
}