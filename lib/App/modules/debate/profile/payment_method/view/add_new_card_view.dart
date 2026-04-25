import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

import '../../../../../core/values/app_color.dart';
import '../../../../../core/values/app_text.dart';
import '../../../../../core/widgets/App_button.dart';
import '../../../../../core/widgets/common_app_bar.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../controller/payment_method_controller.dart';

class AddNewCardView extends StatelessWidget {
  const AddNewCardView({super.key});

  String _formatCardNumber(String input) {
    final digitsOnly = input.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i != 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digitsOnly[i]);
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController());

    controller.cvvFocus.addListener(() {
      controller.isCvvFocused.value = controller.cvvFocus.hasFocus;
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CommonAppBar(
        backgroundColor: Colors.transparent,
        title: 'Add New Card',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // CREDIT CARD UI
              Obx(
                    () => CreditCardWidget(
                  cardNumber: controller.cardNumber.value,
                  expiryDate: controller.expiryDate.value,
                  cardHolderName: controller.cardHolderName.value,
                  cvvCode: controller.cvv.value,
                  isHolderNameVisible: true,
                  showBackView: controller.isCvvFocused.value,
                  onCreditCardWidgetChange: (_) {},
                ),
              ),

              const SizedBox(height: 20),

              // CARD NUMBER
              Text(
                'Card Number',
                style: AppText.body1.semiBold.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hint: '0000 0000 0000 0000',
                hintStyle: const TextStyle(color: Colors.white54),
                textStyle: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.cardNumber.value = _formatCardNumber(value);
                },
                suffix: const Icon(Icons.credit_card_rounded, color: Colors.white),
              ),

              const SizedBox(height: 20),

              // HOLDER NAME
              Text(
                'Card Holder Name',
                style: AppText.body1.semiBold.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hint: 'John Doe',
                hintStyle: const TextStyle(color: Colors.white54),
                textStyle: const TextStyle(color: Colors.white),
                onChanged: (value) =>
                controller.cardHolderName.value = value,
              ),

              const SizedBox(height: 20),

              // EXP + CVV
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiration Date',
                          style: AppText.body1.semiBold
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          hint: 'MM/YY',
                          hintStyle: const TextStyle(color: Colors.white54),
                          textStyle: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                          controller.expiryDate.value = value,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: AppText.body1.semiBold
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          hint: '123',
                          hintStyle: const TextStyle(color: Colors.white54),
                          textStyle: const TextStyle(color: Colors.white),
                          focusNode: controller.cvvFocus,
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                          controller.cvv.value = value,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // SECURITY TEXT
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Payments are securely encrypted with SSL',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              AppButton(
                text: 'Save Card',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}