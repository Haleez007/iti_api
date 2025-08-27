 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:iti_api/features/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:iti_api/features/cart/logic/cubit/add_to_cart_state.dart';
import 'package:iti_api/features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:iti_api/features/wishlist/logic/cubit/wishlist_state.dart';
import 'package:iti_api/core/routing/routes.dart';
import 'package:iti_api/app/presentation/page/get_started.dart';

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
    return BlocBuilder<AddToCartCubit, AddToCartState>(
        builder: (context, cartState) {
          int itemCount = 0;
          if (cartState is CartState) {
            itemCount = cartState.cartItems.length;
          }
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
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
                Navigator.pop(context); // close drawer
                // If not already on home, navigate to home
                Navigator.pushReplacementNamed(context, Routes.home);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context); // close drawer
                Navigator.pushNamed(context, Routes.cart);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Wishlist'),
              onTap: () {
                Navigator.pop(context); // close drawer
                Navigator.pushNamed(context, Routes.wishlist);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Clear app session state (cart + wishlist) then navigate to GetStarted
                final cartCubit = context.read<AddToCartCubit>();
                final wishlistCubit = context.read<WishlistCubit>();
                if (cartCubit is AddToCartCubit) {
                  cartCubit.clearItemsFromCart();
                }
                wishlistCubit.clear();

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const GetStarted()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    Image.asset(
                      'assets/images/logoipsum-255 1.png',
                      height: 30.h,
                      width: 100.w,
                      fit: BoxFit.contain,
                    ),
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: const AssetImage('assets/images/dd.png'),
                    ),
                  ],
                ),
              ),
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
                  margin: EdgeInsets.only(left: 10.h),
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
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.products);
                          },
                          child: Container(
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
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Text(
                            'Now in (get_product)',
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
                              Navigator.pushNamed(context, Routes.products);
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
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.products);
                      },
                      child: Container(
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120.h,
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
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                SizedBox(
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['price']!,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
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
              ),
              Container(
                width: 343.w,
                height: 84.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/Rectangle 56 (1).png',
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Special Offers ',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'We make sure you get the offer you need at best prices',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    left: 8.w,
                    top: 8.h,
                    child: Image.asset(
                      'assets/images/Group 33732.png',
                      width: 77.71.w,
                      height: 156.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: 331.w,
                    height: 155.h,
                    margin: EdgeInsets.only(top: 8.h, left: 8.w, bottom: 20.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4.r),
                      image: DecorationImage(
                        image: AssetImage('assets/images/Rectangle 53.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 172.w,
                    top: 51.h,
                    child: Container(
                      width: 162.w,
                      height: 39.h,
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFF232327),
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'Flat and Heels\n',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF232327),
                              ),
                            ),
                            TextSpan(
                              text: 'Stand a chance to get rewarded',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF232327),
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24.w,
                    top: 40.h,
                    child: Image.asset(
                      'assets/images/Rectangle 55.png',
                      width: 144.w,
                      height: 108.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: 8.w,
                    top: 8.h,
                    child: Container(
                      width: 11.w,
                      height: 171.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Color(0xFFEFAD18),
                            Color(0xFFF8D7B4),
                          ],
                          stops: [0.25, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 235.w,
                    top: 92.h,
                    child: Container(
                      width: 92.w,
                      height: 24.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF83758),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Visit now',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.arrow_forward,
                            size: 14.sp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 343.w,
                height: 70.h,
                margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Color(0xFFFD6E87),
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
                          'Trending Products ',
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
                              Icons.date_range,
                              color: Colors.white,
                              size: 14.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Last Date 29/02/22',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.products);
                      },
                      child: Container(
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
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: 340.w,
                height: 186.h,
                margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w, bottom: 16.h),
                child: GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3, (index) => Container(
                          width: 150.w,
                          height: 210.h,
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.r),
                                  topRight: Radius.circular(4.r),
                                ),
                                child: Image.asset(
                                  index == 1
                                      ? 'assets/images/cot.png'
                                      : 'assets/images/shhhh.png',
                                  width: 142.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        index == 1 ? 'Labbin White Sneakers' : 'IWC Schaffhausen',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        index == 1 ? 'For Men and Female' : '2021 Pilot\'s Watch',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (index != 1) Text(
                                        '44mm',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        index == 1 ? '₹650' : '₹650',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            index == 1 ? '₹1250' : '₹1599',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.grey,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            index == 1 ? '70% off' : '60% off',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 343.w,
                height: 270.h,
                margin: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w, bottom: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: AssetImage('assets/images/Group 33769.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            width: 375.w,
            height: 76.h,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, -1),
                  blurRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home, size: 24.sp, color: Colors.red),
                      onPressed: () {},
                    ),
                    Text('Home', style: TextStyle(fontSize: 10.sp)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<WishlistCubit, WishlistState>(
                      builder: (context, state) {
                        int count = 0;
                        if (state is WishlistLoaded) count = state.items.length;
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite_border, size: 24.sp),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.wishlist);
                              },
                            ),
                            if (count > 0)
                              Positioned(
                                right: 6,
                                top: 6,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$count',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    Text('Wishlist', style: TextStyle(fontSize: 10.sp)),
                  ],
                ),
                SizedBox(width: 60.w),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.search, size: 24.sp),
                          onPressed: () {},
                        ),
                        Text('Search', style: TextStyle(fontSize: 10.sp)),
                      ],
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.settings, size: 24.sp),
                          onPressed: () {},
                        ),
                        Text('Settings', style: TextStyle(fontSize: 10.sp)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 157.5.w,
            top: 1.h,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.cart);
              },
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 16.h,
                      child: Icon(
                        Icons.shopping_cart,
                        size: 28.sp,
                        color: Colors.black87,
                      ),
                    ),
                    if (itemCount > 0) // Only show the badge if there are items in the cart
                      Positioned(
                        top: 10.h,
                        right: 12.w,
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            itemCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );},
          );
        }
  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
    }}
