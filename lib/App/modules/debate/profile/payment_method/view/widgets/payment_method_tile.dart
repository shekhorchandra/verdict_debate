
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/values/app_color.dart';
import '../../../../../../core/values/app_text.dart';
import '../../../../../../data/models/payment_method_model.dart';


class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.paymentMethod,
    this.isSelectable = false,
    this.isSelected = false,
    this.onSelect,
  });

  final PaymentMethodModel paymentMethod;
  final bool isSelectable;
  final bool isSelected;
  final VoidCallback? onSelect;

  String getMaskedNumber(String number) {
    if (number.length <= 4) return number;
    final masked = '*' * (number.length - 4) + number.substring(number.length - 4);
    return masked.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isSelectable ? onSelect : null,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected
              ? AppColor.primary.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          border: Border.all(
            color: isSelected
                ? AppColor.primary
                : Colors.white10,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // LEFT SIDE
            Row(
              children: [
                SvgPicture.asset(paymentMethod.icon),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentMethod.name,
                      style: const TextStyle(
                        color: Colors.white, // ✅ Visa / PayPal white
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      getMaskedNumber(paymentMethod.number),
                      style: const TextStyle(
                        color: Colors.white70, // ✅ readable masked text
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // RIGHT SIDE
            Row(
              children: [
                if (isSelectable)
                  Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.radio_button_off,
                    color: isSelected
                        ? AppColor.primary
                        : Colors.white54,
                  ),

                PopupMenuButton<String>(
                  color: const Color(0xFF1E1B4B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: Colors.white,
                  ),
                  onSelected: (value) {
                    if (value == 'delete') {
                      debugPrint('Delete button pressed!');
                    }
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            color: AppColor.error,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: AppColor.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
