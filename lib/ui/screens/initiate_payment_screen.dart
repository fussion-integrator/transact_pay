import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transact_pay/transact_pay.dart';
import 'package:transact_pay/ui/api/api_config.dart';
import 'package:transact_pay/ui/common_widget/app_button.dart';
import 'package:transact_pay/ui/common_widget/app_field_label.dart';
import 'package:transact_pay/ui/common_widget/app_header.dart';
import 'package:transact_pay/ui/common_widget/app_textfield.dart';
import 'package:transact_pay/ui/constant/app_images.dart';
import 'package:transact_pay/ui/screens/payment_type_screen.dart';
import 'package:transact_pay/ui/screens/popup_dialog/loading_progress_dialog.dart';
import 'package:transact_pay/ui/utils/money_formatter.dart';
import 'package:transact_pay/ui/utils/page_navigator/fading_page_navigator.dart';

class PaymentInitiationScreen extends StatefulWidget {
  const PaymentInitiationScreen({Key? key}) : super(key: key);

  @override
  State<PaymentInitiationScreen> createState() =>
      _PaymentInitiationScreenState();
}

class _PaymentInitiationScreenState extends State<PaymentInitiationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool isValid = false;

  void _validateForm() {
    setState(() {
      isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  late TransactPay transactPay;

  @override
  void initState() {
    super.initState();
    transactPay = TransactPay(apiKey: apiKey, encryptionKey: encryptionKey);
  }

  Future<void> createOrderExample() async {
    final payload = {
      "customer": {
        "firstname": _firstNameController.text,
        "lastname": _lastNameController.text,
        "mobile": _phoneNumberController.text,
        "country": "NG",
        "email": _emailController.text
      },
      "order": {
        "amount": 100,
        "reference": "12121212112",
        "description": "Pay",
        "currency": "NGN"
      },
      "payment": {"RedirectUrl": "https://add-you-webhook"}
    };
    LoadingDialog();

    try {
      final response = await transactPay.createOrder(payload);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar("New Order", "Order created successfully");
        print("Order Created: ${response.body}");
        FadingPageNavigator(
            context,
            PaymentTypeScreen(
              email: _emailController.text,
              amount: _amountController.text,
            ),
            false);
      } else {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);
        Get.snackbar("New Order", decodedJson['message']);
      }
    } catch (e) {
      print("Error creating order: $e");
    }

    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
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
                  const AppFieldLable(text: 'First Name'),
                  AppTextField(
                    controller: _firstNameController,
                    hintText: "Enter first name",
                    validator: (value) => value == null || value.isEmpty
                        ? "First name is required"
                        : null,
                  ),
                  const SizedBox(height: 16.0),
                  const AppFieldLable(text: "Last Name"),
                  AppTextField(
                    controller: _lastNameController,
                    hintText: "Enter last name",
                    validator: (value) => value == null || value.isEmpty
                        ? "Last name is required"
                        : null,
                  ),
                  const SizedBox(height: 16.0),
                  const AppFieldLable(text: "Phone Number"),
                  AppTextField(
                    controller: _phoneNumberController,
                    hintText: "00 0000 0000",
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone number is required";
                      }
                      if (!RegExp(r"^[0-9]{10,11}$").hasMatch(value)) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                    prefix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("  🇳🇬", style: TextStyle(fontSize: 24)),
                        const Text(" +234 "),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.black,
                          height: 32,
                          width: 0.5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const AppFieldLable(text: "Email"),
                  AppTextField(
                    controller: _emailController,
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  const AppFieldLable(text: "Amount"),
                  AppTextField(
                    controller: _amountController,
                    hintText: "Enter amount",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Amount is required";
                      }
                      if (double.tryParse(value.replaceAll(',', '')) == null) {
                        return "Enter a valid number";
                      }
                      if (double.parse(value.replaceAll(',', '')) <= 0) {
                        return "Amount must be greater than 0";
                      }
                      return null;
                    },
                    prefix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("  🇳🇬", style: TextStyle(fontSize: 24)),
                        const Text(" NGN"),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.black,
                          height: 32,
                          width: 0.5,
                        ),
                      ],
                    ),
                    inputFormatters: [
                      MoneyInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const AppFieldLable(
                    text: "Payment Description",
                    optional: true,
                  ),
                  AppTextField(
                    controller: _descriptionController,
                    hintText: "Enter payment description (optional)",
                    maxLines: 3,
                    onChange: (value) {
                      // Ensure that the input is no more than 50 characters
                      if (_descriptionController.text.length > 50) {
                        _descriptionController.text =
                            _descriptionController.text.substring(0, 50);
                        _descriptionController.selection =
                            TextSelection.collapsed(
                                offset: _descriptionController.text.length);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "${_descriptionController.text.length}/50", // Current character count and max length
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  AppButton(
                    onPressed: isValid
                        ? () {
                            createOrderExample();
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
