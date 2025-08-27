import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iti_api/product_model.dart';
import 'cubit/add_to_cart/add_to_cart_cubit.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.subtitle,
  });

  final String image;
  final String title;
  final double price;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    ProductModel selected = ProductModel(
      image: image,
      title: title,
      price: price,
      subtitle: subtitle,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '\$${price ??0}',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final productMap = {
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                      'thumbnail': selected.image,
                      'image': selected.image,
                      'title': selected.title,
                      'subtitle': selected.subtitle,
                      'price': selected.price,
                      'description': selected.subtitle,
                    };
                    context.read<AddToCartCubit>().addToCart(productMap);
                    Fluttertoast.showToast(
                      msg: 'Item added to cart',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}