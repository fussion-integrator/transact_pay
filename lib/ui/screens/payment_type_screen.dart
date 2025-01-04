import 'package:flutter/material.dart';
import 'package:transact_pay/ui/common_widget/app_button.dart';
import 'package:transact_pay/ui/common_widget/app_header.dart';
import 'package:transact_pay/ui/common_widget/app_payment_type_selection.dart';
import 'package:transact_pay/ui/constant/app_colors.dart';
import 'package:transact_pay/ui/constant/app_images.dart';
import 'package:transact_pay/ui/screens/bank_transfer_screen.dart';
import 'package:transact_pay/ui/screens/card_payment_screen.dart';
import 'package:transact_pay/ui/utils/helper.dart';
import 'package:transact_pay/ui/utils/page_navigator/fading_page_navigator.dart';

class PaymentTypeScreen extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? amount;
  final String? description;

  const PaymentTypeScreen(
      {super.key,
      this.email,
      this.firstName,
      this.lastName,
      this.amount,
      this.phone,
      this.description});

  @override
  State<PaymentTypeScreen> createState() => _PaymentTypeScreenState();
}

class _PaymentTypeScreenState extends State<PaymentTypeScreen> {
  // To track the selected index
  int _selectedIndex = -1;

  // Callback to handle selection change
  void _onPaymentTypeSelected(int index) {
    setState(() {
      // Set selected index to the tapped index
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                            Icon(Icons.arrow_back,
                                color: AppColors.primaryColor),
                            Text(
                              " Back",
                              style: TextStyle(color: AppColors.primaryColor),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.email}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "NGN ${widget.amount} ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppHelper.copyToClipboard(
                                    widget.amount!,
                                    message: "Text copied to clipboard!",
                                  );
                                },
                                child: Icon(
                                  Icons.copy_all,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  Visibility(
                    visible: _selectedIndex > -1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Amount ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                        Row(
                          children: [
                            Text(
                              "NGN ${widget.amount} ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                AppHelper.copyToClipboard(
                                  widget.amount!,
                                  message: "Text copied to clipboard!",
                                );
                              },
                              child: Icon(
                                Icons.copy_all,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub Total :  ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              "NGN ${widget.amount} ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Charges :  ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              "NGN 500 ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.3),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Payment Method ",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  // The ListView displaying payment options
                  ListView(
                    padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    children: [
                      AppPaymentTypeSelection(
                        text: 'Pay with bank transfer',
                        imageUrl: AppImages.paper_plane,
                        isSelected: _selectedIndex == 0,
                        onChanged: (isSelected) {
                          if (isSelected) {
                            _onPaymentTypeSelected(0);
                          } else {
                            _onPaymentTypeSelected(-1);
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      AppPaymentTypeSelection(
                        text: 'Pay with card',
                        imageUrl: AppImages.card,
                        isSelected: _selectedIndex == 1,
                        onChanged: (isSelected) {
                          if (isSelected) {
                            _onPaymentTypeSelected(1);
                          } else {
                            _onPaymentTypeSelected(-1);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  AppButton(
                    onPressed: _selectedIndex == 0
                        ? () {
                            FadingPageNavigator(
                                context,
                                BankTransferScreen(
                                  amount: widget.amount,
                                  email: widget.email,
                                ),
                                false);
                          }
                        : _selectedIndex == 1
                            ? () {
                                FadingPageNavigator(
                                    context,
                                    CardPaymentScreen(
                                      amount: widget.amount,
                                      email: widget.email,
                                    ),
                                    false);
                              }
                            : null,
                    text: "Initiate Payment",
                  ),
                  const SizedBox(height: 30),
                  Center(child: Image.asset(AppImages.footer)),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
