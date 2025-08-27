import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_api/core/theme/app_colors.dart';
import 'package:iti_api/features/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:iti_api/features/cart/logic/cubit/add_to_cart_state.dart';
import 'package:iti_api/core/routing/routes.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderNameController = TextEditingController();
  bool _saveCard = false;
  bool _processing = false;
  String _cardBrand = '';

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order summary from cart
              BlocBuilder<AddToCartCubit, AddToCartState>(
                builder: (context, state) {
                  double total = 0;
                  int items = 0;
                  if (state is CartState) {
                    items = state.cartItems.length;
                    total = state.cartItems.fold<double>(0, (sum, item) => sum + (item['price'] ?? 0).toDouble());
                  }
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Items: $items', style: TextStyle(color: AppColors.textSecondary)),
                            const SizedBox(height: 4),
                            Text('Total to pay', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Text(
                          '\$' + total.toStringAsFixed(2),
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Text(
                'Card Information',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  final digits = value.replaceAll(' ', '');
                  _detectCardBrand(digits);
                  final spaced = _groupEvery4(digits);
                  if (spaced != value) {
                    final cursorPos = spaced.length;
                    _cardNumberController.value = TextEditingValue(text: spaced, selection: TextSelection.collapsed(offset: cursorPos));
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1234 5678 9012 3456',
                  prefixIcon: const Icon(Icons.credit_card),
                  suffixIcon: _cardBrand.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Center(
                            widthFactor: 1,
                            child: Text(
                              _cardBrand,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card number';
                  }
                  final digits = value.replaceAll(' ', '');
                  if (!_isValidCardNumber(digits)) {
                    return 'Invalid card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateController,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        final digits = value.replaceAll('/', '');
                        String formatted = digits;
                        if (digits.length > 2) {
                          formatted = digits.substring(0, 2) + '/' + digits.substring(2, digits.length > 4 ? 4 : digits.length);
                        }
                        if (formatted != value) {
                          _expiryDateController.value = TextEditingValue(text: formatted, selection: TextSelection.collapsed(offset: formatted.length));
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'MM/YY',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        if (!_isValidExpiry(value)) {
                          return 'Invalid expiry';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(4)],
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        final len = value.length;
                        // Amex CVV 4, others 3
                        if (_cardBrand == 'AMEX') {
                          if (len != 4) return 'AMEX CVV is 4 digits';
                        } else {
                          if (len != 3) return 'CVV is 3 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _cardHolderNameController,
                decoration: InputDecoration(
                  labelText: 'Cardholder Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cardholder name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              CheckboxListTile(
                value: _saveCard,
                onChanged: (val) {
                  setState(() => _saveCard = val ?? false);
                },
                contentPadding: EdgeInsets.zero,
                title: const Text('Save card for future payments'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _processing
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _processing = true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Processing payment...'),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                            await Future.delayed(const Duration(seconds: 2));
                            if (!mounted) return;
                            setState(() => _processing = false);
                            Navigator.pushReplacementNamed(context, Routes.paymentSuccess);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: _processing
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          'Pay Now',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helpers
  void _detectCardBrand(String digits) {
    String brand = '';
    if (digits.startsWith('4')) brand = 'VISA';
    else if (digits.startsWith('5')) brand = 'MC';
    else if (digits.startsWith('34') || digits.startsWith('37')) brand = 'AMEX';
    else if (digits.startsWith('6')) brand = 'DISC';
    if (brand != _cardBrand) setState(() => _cardBrand = brand);
  }

  String _groupEvery4(String input) {
    final buf = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      if (i != 0 && i % 4 == 0) buf.write(' ');
      buf.write(input[i]);
    }
    return buf.toString();
  }

  bool _isValidCardNumber(String digits) {
    if (digits.length < 12) return false;
    int sum = 0;
    bool alt = false;
    for (int i = digits.length - 1; i >= 0; i--) {
      int n = int.tryParse(digits[i]) ?? 0;
      if (alt) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alt = !alt;
    }
    return sum % 10 == 0;
  }

  bool _isValidExpiry(String value) {
    if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}').hasMatch(value)) {
      // fallback simple check if regex above fails due to escapes
    }
    final parts = value.split('/');
    if (parts.length != 2) return false;
    final month = int.tryParse(parts[0]) ?? 0;
    final year2 = int.tryParse(parts[1]) ?? -1;
    if (month < 1 || month > 12 || year2 < 0) return false;
    final now = DateTime.now();
    final year = 2000 + year2;
    // set expiry end of month
    final lastDay = DateTime(year, month + 1, 0);
    return lastDay.isAfter(DateTime(now.year, now.month, 1));
  }
}