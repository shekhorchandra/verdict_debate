// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../core/values/app_text.dart';
// import '../../waiting/views/WaitingDebateView.dart';
// import '../controller/DebatesController.dart';
// import 'DebatesLiveNowView.dart';
// // Import your sub-views
//
// class DebatesView extends GetView<DebatesController> {
//   const DebatesView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // We use extendBodyBehindAppBar to make the background fill the screen
//       body: Stack(
//         children: [
//           // 1. Shared Background (So it doesn't flicker when switching tabs)
//           _buildBackground(),
//
//           // 2. Conditional Body Content
//           Obx(() => _getTabBody(controller.selectedTab.value)),
//
//           // 3. Fixed Top Tabs (Always on top)
//           SafeArea(
//             child: _buildTopTabs(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _getTabBody(int index) {
//     switch (index) {
//       case 0:
//         return const Center(child: Text("All Debates", style: TextStyle(color: Colors.white)));
//       case 1:
//         return const DebatesLiveNowView(); // Your existing Live view
//       case 2:
//         return const DebatesWaitingView(); // The view we created previously
//       default:
//         return const SizedBox();
//     }
//   }
//
//   Widget _buildBackground() {
//     return Obx(() {
//       // Dynamic background color based on tab
//       bool isWaiting = controller.selectedTab.value == 2;
//       return AnimatedContainer(
//         duration: const Duration(milliseconds: 500),
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: isWaiting
//                 ? [const Color(0xFFC30052), const Color(0xFF00909A)] // Pink/Teal for Waiting
//                 : [const Color(0xFF1E1B4B), const Color(0xFF312E81)], // Dark Indigo for Live
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _buildTopTabs() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _navTab("All", 0),
//           const SizedBox(width: 30),
//           _navTab("Live Now", 1),
//           const SizedBox(width: 30),
//           _navTab("Waiting", 2),
//         ],
//       ),
//     );
//   }
//
//   Widget _navTab(String title, int index) {
//     return Obx(() {
//       bool isSelected = controller.selectedTab.value == index;
//       return GestureDetector(
//         onTap: () => controller.changeTab(index),
//         child: Text(
//           title,
//           style: AppText.h5().copyWith(
//             color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       );
//     });
//   }
// }



//------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/values/app_text.dart';
import '../controller/DebatesController.dart';

class DebatesView extends GetView<DebatesController> {
  const DebatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Center(
            // ✅ Full content center
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.10),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.campaign_rounded,
                      color: Colors.white,
                      size: 85,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Debates Arena",
                      style: AppText.h3.bold.copyWith(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      "Coming Soon",
                      style: AppText.h4.bold.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "This feature will be launched in the next phase.\nStay tuned for exciting updates!",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 28),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "🔥 Next Phase Release",
                        style: AppText.body1.bold.copyWith(
                          color: const Color(0xFF312E81),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}