import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transact_pay/transact_pay.dart';
import 'package:transact_pay/ui/api/api_config.dart';
import 'package:transact_pay/ui/common_widget/app_bank_detail.dart';
import 'package:transact_pay/ui/common_widget/app_button.dart';
import 'package:transact_pay/ui/common_widget/app_countdown_timer.dart';
import 'package:transact_pay/ui/common_widget/app_header.dart';
import 'package:transact_pay/ui/constant/app_colors.dart';
import 'package:transact_pay/ui/constant/app_images.dart';
import 'package:transact_pay/ui/screens/popup_dialog/bank_transfer_progress_popup.dart';

class BankTransferScreen extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? amount;
  final String? description;

  const BankTransferScreen(
      {super.key,
      this.email,
      this.firstName,
      this.lastName,
      this.amount,
      this.phone,
      this.description});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  late TransactPay transactPay;

  @override
  void initState() {
    super.initState();
    transactPay = TransactPay(apiKey: apiKey, encryptionKey: encryptionKey);
  }

  Future<void> createOrderExample() async {
    final payload = {
      "reference": "{{orderreference}}",
      "paymentoption": "bank-transfer",
      "country": "NG",
      "BankTransfer": {"bankcode": "000017"}
    };

    try {
      final response = await transactPay.createOrder(payload);
      Get.snackbar("New Order", "Order created successfully");
      print("Order Created: ${response.body}");
      // FadingPageNavigator(
      //     context,
      //     PaymentTypeScreen(
      //       email: _emailController.text,
      //       amount: _amountController.text,
      //     ),
      //     false);
    } catch (e) {
      print("Error creating order: $e");
    }
  }

  Future<void> validateAccNumber() async {
    final payload = {
      "reference": "{{orderreference}}",
      "paymentoption": "bank-transfer",
      "country": "NG",
      "BankTransfer": {"bankcode": "000017"}
    };

    try {
      final response = await transactPay.createOrder(payload);
      Get.snackbar("New Order", "Order created successfully");
      print("Order Created: ${response.body}");
    } catch (e) {
      print("Error creating order: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: AppHeader(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, color: AppColors.primaryColor),
                          Text(
                            " Back",
                            style: TextStyle(color: AppColors.primaryColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text:
                            "Transfer NGN ${widget.amount} to ", // First text in normal style
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black, // Adjust color as needed
                        ),
                        children: [
                          TextSpan(
                            text: "17008801838. ", // Second text in bold
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.copy_all,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(10),
                  //padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.3)),
                  child: Column(
                    children: [
                      AppBankDetail(
                        title: "Amount",
                        infoText: "Final amount has added cost of transfer",
                        subtitle: "NGN ${widget.amount}",
                        onIconTap: () {
                          print("Subtitle: Bank Account");
                        },
                      ),
                      Divider(thickness: 0.5),
                      AppBankDetail(
                        title: "Account Number",
                        subtitle: "1700801838",
                        onIconTap: () {
                          print("Subtitle: Bank Account");
                        },
                      ),
                      Divider(thickness: 0.5),
                      AppBankDetail(
                        title: "Bank",
                        subtitle: "MoniePoint",
                        onIconTap: () {
                          print("Subtitle: Bank Account");
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Account details is valid for this transaction only and it will expire in ", // First text
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      WidgetSpan(
                        child: AppCountdownTimer(
                          durationInSeconds: 600,
                        ),
                      ),
                      TextSpan(
                        text: " minutes", // Final text
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                AppButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          surfaceTintColor: Colors.white,
                          child: IntrinsicHeight(
                            child: IntrinsicWidth(
                              child: const BankTransferProgressPopup(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  text: "I have sent the money",
                ),
                const SizedBox(height: 30),
                Center(child: Image.asset(AppImages.footer)),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
