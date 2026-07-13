import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verdict_debate/App/modules/debate/profile/payment_method/view/widgets/payment_method_tile.dart';
import '../../../../../core/values/app_color.dart';
import '../../../../../core/values/app_sizes.dart';
import '../../../../../core/values/app_text.dart';
import '../../../../../core/widgets/App_button.dart';
import '../../../../../core/widgets/common_app_bar.dart';
import '../../../../../data/mock_data/mock_payment_method.dart';
import '../../../../../routes/app_routes.dart';
import '../controller/payment_method_controller.dart';

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({super.key, this.isSelectable = false});

  final bool? isSelectable;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CommonAppBar(backgroundColor: Colors.transparent, title: 'Payment Methods'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Payment section text
              Text(
                'For Payment',
                style: AppText.body1.bold.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                final selected = controller.selectedPaymentMethod.value;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mockPaymentMethod.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        PaymentMethodTile(
                          paymentMethod: mockPaymentMethod[index],
                          isSelectable: isSelectable ?? false,
                          isSelected: selected == index,
                          onSelect: () => controller.selectedPaymentMethod.value = index,
                        ),

                        const SizedBox(height: 10),
                      ],
                    );
                  },
                );
              }),

              const SizedBox(height: 4),
              // Add new card
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () => Get.toNamed(AppRoutes.ADD_PAYMENT_METHOD),
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    radius: Radius.circular(16),
                    dashPattern: [15, 5],
                    strokeWidth: 2,
                    padding: EdgeInsets.all(20),
                    color: Color(0xFF6366F1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add_rounded, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        'Add new card',
                        style: AppText.body2.medium.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'For Payout',
                    style: AppText.body1.bold.copyWith(
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Your earnings from live debate_final_4 gifts can be withdrawn once you add your bank account details.',
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 16),

                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Get.toNamed(AppRoutes.ADD_PAYMENT_METHOD),
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: const Radius.circular(16),
                        dashPattern: const [15, 5],
                        strokeWidth: 2,
                        padding: const EdgeInsets.all(20),
                        color: const Color(0xFF6366F1),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Add bank account',
                            style: AppText.body2.medium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isSelectable ?? false
            ? AppButton(
                text: 'Publish Deal',
                onPressed: () {
                  if (controller.selectedPaymentMethod == -1) {
                    Get.snackbar(
                      'Error',
                      'Please select a payment method!',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: AppColor.error,
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(15),
                    );
                  }
                },
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
