import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iti_api/app/presentation/page/onboarding_model.dart';
import 'package:iti_api/core/routing/routes.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  int currentPage = 0;
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with page number and skip button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 22.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${currentPage + 1}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        ' / ${onboardingTitles.length}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(Routes.getStarted);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView content
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                controller: controller,
                itemCount: onboardingTitles.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),
                        SizedBox(
                          height: 300.h,
                          width: 300.w,
                          child: SvgPicture.asset(onboardingImages[index]),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          onboardingTitles[index],
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            onboardingSubTitles[index],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom navigation
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Prev (left)
                  SizedBox(
                    width: 90.w,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: currentPage > 0
                          ? TextButton(
                              onPressed: () {
                                controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),

                  // Dots (center)
                  DotsIndicator(
                    dotsCount: onboardingTitles.length,
                    position: currentPage.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: Colors.black,
                      color: Colors.grey,
                      size: const Size(10, 10),
                      activeSize: const Size(40, 10),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ),

                  // Next / Get Started (right)
                  SizedBox(
                    width: 110.w,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (currentPage == onboardingTitles.length - 1) {
                            Navigator.of(context).pushReplacementNamed(Routes.getStarted);
                          } else {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(
                          currentPage == onboardingTitles.length - 1 ? 'Get Started' : 'Next',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}