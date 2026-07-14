import 'package:get/get.dart';

class BudgetOption {
  final String amount;
  final String reach;
  BudgetOption(this.amount, this.reach);
}

class BoostPollController extends GetxController {
  // Budget Selection
  var selectedBudgetIndex = 1.obs; // Default to $10
  final List<BudgetOption> budgetOptions = [
    BudgetOption("\$5", "1K-2K people"),
    BudgetOption("\$10", "2K-5K people"),
    BudgetOption("\$20", "5K-10K people"),
    BudgetOption("Custom", "Set your own budget"),
  ];

  // Duration Selection
  var selectedDuration = "3 Days".obs;

  // List of duration options
  final List<String> durationOptions = [
    "1 Day",
    "3 Days",
    "7 Days",
    "14 Days",
    "30 Days",
  ];



  // Summary Data (Reactive based on budget)
  String get estimatedReach => budgetOptions[selectedBudgetIndex.value].reach.split(' ').first;
  String get budgetAmount => budgetOptions[selectedBudgetIndex.value].amount == "Custom"
      ? "\$0" : budgetOptions[selectedBudgetIndex.value].amount;

  String get expectedImpressions {
    if (selectedBudgetIndex.value == 0) return "3K-6K";
    if (selectedBudgetIndex.value == 1) return "6K-15K";
    return "15K-30K";
  }

  void selectBudget(int index) => selectedBudgetIndex.value = index;

  void handlePayment() {
    Get.snackbar("Processing", "Redirecting to payment gateway...");
  }
  void updateDuration(String? newValue) {
    if (newValue != null) {
      selectedDuration.value = newValue;
    }
  }
}