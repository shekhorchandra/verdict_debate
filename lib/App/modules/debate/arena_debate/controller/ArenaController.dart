import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verdict_debate/App/core/values/app_assets.dart';

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

    {
      "label": "Top Polls",
      "icon": Icons.poll
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
// Inside ArenaController class
  final List<Map<String, dynamic>> topPolls = [
    {
      "user": "@zara_debates",
      "time": "Ends 1 week ago",
      "userImg": "https://i.pravatar.cc/150?u=zara",
      "question": "Should remote work be the default for tech companies?",
      "description": "Remote work increases productivity and work-life balance. Companies save on office costs while employees gain flexibility and reduce commute time.",
      "pollImg": "https://images.unsplash.com/photo-1522071820081-009f0129c71c",
      "votes": "3,420",
      "likes": "1.1k",
      "shares": "154",
      "comments": "32",
      "disagree": 23,
      "agree": 77,
    },
    {
      "user": "@zara_debates",
      "time": "Ends 2 days ago",
      "userImg": "https://i.pravatar.cc/150?u=zara2",
      "question": "Will AI eventually replace software engineers?",
      "description": "The rise of LLMs has sparked a global debate_final_4. Some see it as a tool, while others fear full automation.",
      "pollImg": "https://images.unsplash.com/photo-1677442136019-21780ecad995",
      "votes": "12,100",
      "likes": "5.4k",
      "shares": "890",
      "comments": "150",
      "disagree": 45,
      "agree": 55,
    },
  ];
}