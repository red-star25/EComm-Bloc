import 'package:ecomm/constants/colors.dart';
import 'package:ecomm/payment/paytmconfig.dart';
import 'package:flutter/material.dart';

class CheckoutBtn extends StatelessWidget {
  const CheckoutBtn({
    Key? key,
    required this.paytmConfig,
  }) : super(key: key);

  final PaytmConfig paytmConfig;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await paytmConfig.generateTxnToken(1, '1');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            'Proceed to Checkout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
