import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iti_api/onboarding_model.dart';

import 'get_started.dart';

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
        child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 22.h),
          child: Column(
            children: [
              Row(
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
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const GetStarted ()),
                      );
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
              SizedBox(height: 100.h),
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
                    return Column(
                      children: [
                        SizedBox(
                          height: 300.h,
                          width: 300.w,
                          child: SvgPicture.asset(onboardingImages[index]),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          onboardingTitles[index],
                          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          onboardingSubTitles[index],
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentPage == 0
                      ? SizedBox()
                      : InkWell(
                          onTap: () {
                            controller.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Text(
                            "Prev",
                            style: TextStyle(color: Colors.grey, fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                  DotsIndicator(
                    dotsCount: onboardingTitles.length,
                    position: currentPage.toDouble(),
                    decorator: DotsDecorator(
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      activeColor: Colors.black,
                      color: Colors.grey,
                      size: Size(10, 10),
                      activeSize: Size(40, 10),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (currentPage == 2) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const GetStarted()),
                        );
                      } else {
                        controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Text(
                      currentPage == 2 ? "GetStarted" : 'Next',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ));
  }
}