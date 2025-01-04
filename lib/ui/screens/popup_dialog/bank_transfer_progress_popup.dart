import 'package:flutter/material.dart';
import 'package:transact_pay/ui/common_widget/app_button.dart';
import 'package:transact_pay/ui/common_widget/app_consent_checkbox.dart';
import 'package:transact_pay/ui/common_widget/app_countdown_timer.dart';
import 'package:transact_pay/ui/constant/app_colors.dart';
import 'package:transact_pay/ui/constant/app_images.dart';

class BankTransferProgressPopup extends StatefulWidget {
  const BankTransferProgressPopup({super.key});

  @override
  State<BankTransferProgressPopup> createState() =>
      _BankTransferProgressPopupState();
}

class _BankTransferProgressPopupState extends State<BankTransferProgressPopup> {
  int currentStep = 0;
  bool isWaiting = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Visibility(
            visible: currentStep < 2,
            child: Column(
              children: [
                CircularProgressIndicator(
                  strokeWidth: 5,
                  color: AppColors.primaryColor,
                  strokeCap: StrokeCap.round,
                ),
                SizedBox(height: 20),
                Text(
                  "Checking Transaction Status",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: currentStep < 2,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "This may take up to ", // First text
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        WidgetSpan(
                          child: AppCountdownTimer(
                            durationInSeconds: 20,
                            onRemainingTimeChanged: (value) {
                              if (value < 20 / 2 && !isWaiting) {
                                setState(() {
                                  currentStep = 1;
                                });
                              }
                            },
                            onCountdownFinished: () {
                              setState(() {
                                currentStep = 2;
                              });
                            },
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
                ),
                Visibility(
                  visible: currentStep == 1,
                  child: Column(
                    children: [
                      Text(
                        "This is taking longer than expected. "
                        "Do you want to get notified when your "
                        "transaction is completed or continue waiting?",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 100,
                            child: AppButton(
                              text: "Wait",
                              textStyle:
                                  TextStyle(color: AppColors.primaryColor),
                              width: MediaQuery.of(context).size.width / 3,
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  currentStep = 0;
                                  isWaiting = true;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            width: 120,
                            child: AppButton(
                              text: "Notify Me",
                              textStyle:
                                  TextStyle(fontSize: 13, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  currentStep = 2;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: currentStep == 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.info,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Pending Payment",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  "A mail will be sent to you once your transaction is confirmed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 30),
                AppButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Close",
                ),
              ],
            ),
          ),
          Visibility(
            visible: currentStep == 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.completed,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Payment Completed",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: AppButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Finish",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(child: Image.asset(AppImages.footer, width: 180)),
          // SizedBox(height: 20),
          // AppConsentCheckbox(
          //   text: "Show Success Screen",
          //   //textStyle: TextStyle(fontSize: 16.0, color: Colors.blue),
          //   onChanged: () {
          //     setState(() {
          //       currentStep = 3;
          //     });
          //   },
          // ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
