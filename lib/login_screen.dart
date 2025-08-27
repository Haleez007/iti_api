import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_api/common/textfield_widget.dart';
import 'signup_screen.dart';
import 'home_page.dart'; // Add this line

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40.h),

                TextFieldWidget(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                  controller: _emailController,
                ),
                SizedBox(height: 20.h),

                TextFieldWidget(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h, top: 40.h),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Or Continue with'),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55.h,
                              width: 55.w,
                              decoration: BoxDecoration(
                                color: Color(0xFFFCF3F6),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0xFFFCF3F6)
                                ),
                              ),
                              child:Center(
                                child: Image.asset(
                                  'assets/images/Google.png',
                                  fit: BoxFit.cover,
                                  height: 52.h,
                                  // width: 60.w,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              height: 55.h,
                              width: 65.w,
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
                              height: 55.h,
                              width: 55.w,
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
                  ),
                ),
                SizedBox(height: 0.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
