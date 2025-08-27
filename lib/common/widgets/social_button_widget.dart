import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Or Continue with'),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFCF3F6),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFF83758)
                  ),
                ),
                child:Center(
                  child: Image.asset(
                    'assets/images/Google.png',
                    fit: BoxFit.cover,
                    height: 42.h,
                    // width: 60.w,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFCF3F6),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFF83758)
                  ),
                ),
                child:  Icon(
                  Icons.facebook,
                  color: Color(0xFF3D4DA6),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFCF3F6),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFF83758)
                  ),
                ),
                child:  Icon(
                  Icons.apple,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}