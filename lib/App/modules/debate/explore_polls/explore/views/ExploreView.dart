import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/ExploreController.dart';

class ExploreView extends GetView<ExploreViewController> {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1029),
      body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [

              /// ✅ TOP NAV (ADDED HERE)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      const Spacer(),
                      Obx(() => _navItem("For you", 0)),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.white24,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      Obx(() => _navItem("Following", 1)),
                      const Spacer(),
                      const Icon(Icons.notifications, color: Color(0xFF818CF8), size: 28),
                    ],
                  ),
                ),
              ),

              /// BACKGROUND LAYERS
              Positioned(top: 80, child: _stackedLayer(0.75, Colors.white.withOpacity(0.1))),
              Positioned(top: 95, child: _stackedLayer(0.85, Colors.white.withOpacity(0.2))),

              /// MAIN CARD AREA
              Positioned.fill(
                top: 80,
                child: Obx(() {
                  int current = controller.currentIndex.value;
                  int next = (current + 1) % controller.debates.length;
                  Offset offset = controller.cardOffset.value;

                  return Stack(
                    children: [
                      _buildMainContent(controller.debates[next], isUnderneath: true),

                      GestureDetector(
                        onTap: () => controller.openDetails(), // 👈 ADD THIS
                        onPanUpdate: (details) {
                          controller.cardOffset.value += details.delta;
                        },
                        onPanEnd: (details) {
                          final o = controller.cardOffset.value;

                          if (o.dx > 150) {
                            controller.swipeRight();
                          }
                          else if (o.dx < -150) {
                            controller.swipeLeft();
                          }
                          else if (o.dy < -150) {
                            controller.swipeUp();
                          }
                          else if (o.dy > 150) {
                            controller.swipeDown(); // 👈 OPEN DETAILS
                          }
                          else {
                            controller.resetCard();
                          }
                        },
                        child: Obx(() {
                          Offset o = controller.cardOffset.value;
                          double angle = o.dx / 1000;

                          return Transform.translate(
                            offset: o,
                            child: Transform.rotate(
                              angle: angle,
                              child: Stack(
                                children: [
                                  _buildMainContent(controller.debates[current]),

                                  if (o.dx > 50)
                                    _buildVoteOverlay(
                                      icon: Icons.thumb_up,
                                      label: "Agree",
                                      colors: [Color(0xFF6EE2F5), Color(0xFF00B4D8)],
                                      opacity: (o.dx / 150).clamp(0, 1),
                                    ),

                                  if (o.dx < -50)
                                    _buildVoteOverlay(
                                      icon: Icons.thumb_down,
                                      label: "Disagree",
                                      colors: [Color(0xFFFF5B99), Color(0xFFFF006E)],
                                      opacity: (o.dx.abs() / 150).clamp(0, 1),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                }),
              ),
            ],
          )
      ),
    );
  }

  Widget _buildMainContent(Map<String, dynamic> data, {bool isUnderneath = false}) {
    // Explicit casts to handle potential double/int mix in data
    int disVal = data['disagree'] is int ? data['disagree'] : (data['disagree'] as num).toInt();
    int agrVal = data['agree'] is int ? data['agree'] : (data['agree'] as num).toInt();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 30, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: isUnderneath
            ? []
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cardHeader(data),
                const SizedBox(height: 20),
                Text(
                  data['title'],
                  style: AppText.h3.bold.copyWith(color: Colors.black, height: 1.2),
                ),
                const SizedBox(height: 12),
                Text(
                  data['desc'],
                  style: AppText.body2().copyWith(color: Colors.grey[700]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    data['image'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                _pollSection(disVal, agrVal),
                const SizedBox(height: 20),
                _actionButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String title, int index) {
    bool isSelected = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Row(
        children: [
          if (isSelected) const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
          if (isSelected) const SizedBox(width: 4),
          Text(
            title,
            style: AppText.h5().copyWith(
              color: isSelected ? Colors.white : Colors.white60,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pollSection(int dis, int agr) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$dis% Disagree",
              style: AppText.label().copyWith(
                color: const Color(0xFFFF006E),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$agr% Agree",
              style: AppText.label().copyWith(
                color: const Color(0xFF00B4D8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: dis,
              child: Container(
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF006E),
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                ),
              ),
            ),
            Expanded(
              flex: agr,
              child: Container(
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF00B4D8),
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVoteOverlay({
    required IconData icon,
    required String label,
    required List<Color> colors,
    required double opacity,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 30, 16, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 80),
              const SizedBox(height: 10),
              Text(label, style: AppText.h3.bold.copyWith(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stackedLayer(double w, Color c) => Container(
    width: Get.width * w,
    height: 100,
    decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(40)),
  );


  Widget _cardHeader(Map<String, dynamic> d) => Row(
    children: [
      CircleAvatar(radius: 25, backgroundImage: NetworkImage(d['image'])),
      const SizedBox(width: 12),
      Expanded(
        child: Text(d['user'], style: AppText.h4.bold.copyWith(color: Colors.black)),
      ),
      const Text("Ends: 05/04", style: TextStyle(color: Colors.grey, fontSize: 12)),
    ],
  );

  Widget _actionButtons() => Row(
    children: [
      _btn(Icons.favorite_border),
      const SizedBox(width: 12),
      _btn(Icons.repeat),
      const SizedBox(width: 12),
      _btn(Icons.chat_bubble_outline),
    ],
  );

  Widget _btn(IconData i) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF818CF8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(i, color: Colors.white),
    ),
  );
}







// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../core/values/app_text.dart';
// import '../controller/ExploreController.dart';
//
// class ExploreView extends GetView<ExploreViewController> {
//   const ExploreView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SizedBox(
//         width: double.infinity,
//         height: double.infinity,
//         child: SafeArea(
//           child: Center(
//             // ✅ Full content center
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(28),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(.10),
//                   borderRadius: BorderRadius.circular(28),
//                   border: Border.all(color: Colors.white24),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.campaign_rounded,
//                       color: Colors.white,
//                       size: 85,
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     Text(
//                       "Polls",
//                       style: AppText.h3.bold.copyWith(
//                         color: Colors.white,
//                         fontSize: 28,
//                       ),
//                     ),
//
//                     const SizedBox(height: 14),
//
//                     Text(
//                       "Coming Soon",
//                       style: AppText.h4.bold.copyWith(
//                         color: Colors.white,
//                         fontSize: 24,
//                       ),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     Text(
//                       "This feature will be launched in the next phase.\nStay tuned for exciting updates!",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         height: 1.5,
//                       ),
//                     ),
//
//                     const SizedBox(height: 28),
//
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Text(
//                         "🔥 Next Phase Release",
//                         style: AppText.body1.bold.copyWith(
//                           color: const Color(0xFF312E81),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }