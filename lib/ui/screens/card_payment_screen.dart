import 'package:flutter/material.dart';
import 'package:transact_pay/ui/common_widget/app_button.dart';
import 'package:transact_pay/ui/common_widget/app_consent_checkbox.dart';
import 'package:transact_pay/ui/common_widget/app_field_label.dart';
import 'package:transact_pay/ui/common_widget/app_header.dart';
import 'package:transact_pay/ui/common_widget/app_textfield.dart';
import 'package:transact_pay/ui/constant/app_colors.dart';
import 'package:transact_pay/ui/constant/app_images.dart';
import 'package:transact_pay/ui/screens/popup_dialog/card_payment_progress_popup.dart';
import 'package:transact_pay/ui/screens/saved_card_payment_screen.dart';
import 'package:transact_pay/ui/utils/credit_card_formatter.dart';
import 'package:transact_pay/ui/utils/expiry_date_formatter.dart';
import 'package:transact_pay/ui/utils/page_navigator/fading_page_navigator.dart';

class CardPaymentScreen extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? amount;
  final String? description;

  const CardPaymentScreen(
      {super.key,
      this.email,
      this.firstName,
      this.lastName,
      this.amount,
      this.phone,
      this.description});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isValid = false;

  void _validateForm() {
    setState(() {
      isValid = _formKey.currentState?.validate() ?? false;
    });
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
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                onChanged: _validateForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.copy_all,
                                  color: AppColors.primaryColor,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(thickness: 0.5),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enter your card details",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            FadingPageNavigator(
                                context,
                                SavedCardPaymentScreen(
                                  email: widget.email,
                                  amount: widget.amount,
                                ),
                                false);
                          },
                          child: Text(
                            "Pay with saved card",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const AppFieldLable(text: "Card Number"),
                    AppTextField(
                      controller: _cardNumberController,
                      hintText: "Enter your card number",
                      keyboardType: TextInputType.number,
                      inputFormatters: [CreditCardFormatter()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Card number is required";
                        }
                        if (!RegExp(r"^\d{4} \d{4} \d{4} \d{4}$")
                            .hasMatch(value)) {
                          return "Enter a valid card number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const AppFieldLable(text: "Expiry Date"),
                    AppTextField(
                      controller: _expiryDateController,
                      hintText: "MM / YY",
                      keyboardType: TextInputType.number,
                      inputFormatters: [ExpiryDateFormatter()],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Expiry date is required";
                        }
                        if (!RegExp(r"^(0[1-9]|1[0-2])\/\d{2}$")
                            .hasMatch(value)) {
                          return "Enter a valid expiry date (MM/YY)";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const AppFieldLable(text: "CVV"),
                    AppTextField(
                      controller: _cvvController,
                      hintText: "***",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "CVV is required";
                        }
                        // Regex to validate the CVV format (3 or 4 digits)
                        if (!RegExp(r"^\d{3,4}$").hasMatch(value)) {
                          return "Enter a valid CVV";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    AppConsentCheckbox(
                      text:
                          "Save my card information for a faster checkout next time",
                    ),
                    SizedBox(height: 50),
                    AppButton(
                      onPressed: isValid
                          ? () {
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
                                        child: const CardPaymentProgressPopup(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          : null,
                      text: "Pay NGN ${widget.amount}",
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
      ),
    );
  }
}
