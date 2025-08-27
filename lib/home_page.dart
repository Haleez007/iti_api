 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/dd.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nada Mahmoud',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'nada.mahmoud@gmail.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('My Orders'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with menu, logo, and profile
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menu Button
                    Builder(
                      builder: (context) => IconButton(
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                                (index) => Container(
                              width: 24.w,
                              height: 2.h,
                              margin: EdgeInsets.symmetric(vertical: 1.h),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),

                    // Logo
                    Image.asset(
                      'assets/images/logoipsum-255 1.png',
                      height: 30.h,
                      width: 100.w,
                      fit: BoxFit.contain,
                    ),

                    // Profile Picture
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: const AssetImage('assets/images/dd.png'),
                    ),
                  ],
                ),
              ),

              // Search Box
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Search any Product..',
                      hintStyle: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[500],
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Icon(
                          Icons.mic,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                    ),
                    onSubmitted: (value) {
                      print('Searching for: $value');
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Featured',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8.w),
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.swap_vert,
                                size: 16.sp,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Sort',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_list,
                                size: 16.sp,
                                color: Colors.grey[600],
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Filter',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.h,
                width: double.infinity,
                child: Container(
                    margin: EdgeInsets.only( left: 10.h ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 10.h,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      padding: EdgeInsets.only(right: 5.w),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final images = [
                          "assets/images/Ellipse 4.png",
                          'assets/images/unsplash__3Q3tsJ01nc (1).png',
                          'assets/images/unsplash_GCDjllzoKLo.png',
                          'assets/images/unsplash_xPJYL0l5Ii8 (1).png',
                          'assets/images/unsplash_OYYE4g-I5ZQ.png',
                        ];
                        final labels = [
                          'Beauty',
                          'Fashions',
                          'Kids',
                          'Mens',
                          'Womens',
                        ];
                        return Container(
                          height: 60.h,
                          width: 60.w,
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50.w,
                                height: 50.h,
                                child: ClipOval(
                                  child: Image.asset(
                                    images[index],
                                    width: 50.w,
                                    height: 50.h,

                                  ),
                                ),
                              ),
                              SizedBox(width: 70.w,),
                              Text(
                                labels[index],
                                style: TextStyle(
                                  color: Color(0xFF21003D),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/Rectangle 48.png',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 15.h),
                          DotsIndicator(
                            dotsCount: 3,
                            position: _currentPageIndex.toDouble()==1?1:1,
                            decorator: DotsDecorator(
                              activeColor: Color(0xFFF83758),
                              color: Color(0xFFDEDBDB),
                              size: Size(8.w, 8.w),
                              activeSize: Size(8.w, 8.w),
                              spacing: EdgeInsets.symmetric(horizontal: 4.w),
                            ),
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),


                    Positioned(
                      left: 20.w,
                      top: 0,
                      bottom: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '50-40% OFF',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),                            ),
                          ),
                          Text(
                            'Now in (product)',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Text(
                            'All colours',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          TextButton(
                            onPressed: () {
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 1.w,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Shop Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 14.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 343.w,
                height: 70.h,
                margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Color(0xFF4392F9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Deal of the Day',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(
                              Icons.access_alarm,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '22h 55m 20s remaining',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: 89.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.w,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Container(
                height: 245.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    // Product data
                    final products = [
                      {
                        'image': 'assets/images/Mask Group.png',
                        'title': 'Women Printed Kurta',
                        'description': 'Elegant and comfortable kurta for women',
                        'price': '₹1,500',
                        'originalPrice': '₹2,499',
                        'ratingCount': '548,455',
                      },
                      {
                        'image': 'assets/images/sh..png',
                        'title': 'HRX by Hrithik Roshan',
                        'description': 'Neque porro quisquam est qui dolorem ipsum quia',
                        'price': '₹2,499',
                        'originalPrice': '₹4,999',
                        'ratingCount': '721,789',
                      },
                    ];

                    final product = products[index];

                    return Container(
                      width: 150.w,
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,  // Added this line
                        children: [
                          // Product Image
                          Container(
                            width: double.infinity,
                            height: 120.h,  // Increased image height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.r),
                                topRight: Radius.circular(12.r),
                              ),
                              image: DecorationImage(
                                image: AssetImage(product['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Product Details
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  product['title']!,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                // Description
                                SizedBox(  // Added fixed height container
                                  height: 30.h,
                                  child: Text(
                                    product['description']!,
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: Colors.grey[600],
                                      height: 1.2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                // Price and Discount
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['price']!,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          product['originalPrice']!,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                                          decoration: BoxDecoration(
                                            color: Colors.red.shade50,
                                            borderRadius: BorderRadius.circular(4.r),
                                          ),
                                          child: Text(
                                            '50% Off',
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),

                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(5, (starIndex) => Icon(
                                        starIndex < 4 ? Icons.star : Icons.star_border,
                                        color: starIndex < 4 ? Colors.amber : Colors.grey[400],
                                        size: 12.sp,
                                      )),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      '(${product['ratingCount']})',
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),],
          ),

        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}