 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Task8 extends StatelessWidget {
  const Task8({super.key});

@override
Widget build(BuildContext context) {
return StoreScreen();
//   ScreenUtilInit(
// designSize: Size(375, 812),
// builder: (context, child) {
// return
//   MaterialApp(
//
//
// debugShowCheckedModeBanner: true,
// theme: ThemeData(
// fontFamily: "Cairoo",
// primarySwatch: Colors.blue,
// ),
// home: StoreScreen(),
// );


}
}

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

@override
_StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
int cartcount = 0;
TextEditingController searchcontroller = TextEditingController();

@override
void dispose() {
  searchcontroller.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
backgroundColor: Colors.blue,
elevation: 4,
title: Row(
children: [
Icon(Icons.storefront, size: 30, color: Colors.white),
SizedBox(width: 10),
Text(
"MyShop",
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),
],
),
actions: [
Stack(
children: [
IconButton(
icon: Icon(Icons.shopping_cart, size: 28, color: Colors.white),
onPressed: null,
),
if (cartcount > 0)
Positioned(
right: 6,
top: 6,
child: Container(
padding: EdgeInsets.all(4),
decoration: BoxDecoration(
color: Colors.red,
shape: BoxShape.circle,
),
child: Text(
'$cartcount',
style: TextStyle(
color: Colors.white,
fontSize: 12,
fontWeight: FontWeight.bold,
),
),
),
),
],
),
],
),
body: SafeArea(
child: Padding(
padding: EdgeInsets.all(16),
child: Column(
children: [
Container(
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
boxShadow: [
BoxShadow(
color: Colors.grey.shade300,
blurRadius: 6,
offset: Offset(0, 7),
),
],
),
child: TextField(
controller: searchcontroller,
decoration: InputDecoration(
hintText: "Search products",
border: InputBorder.none,
prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
contentPadding: EdgeInsets.symmetric(vertical: 14),
),
),
),
SizedBox(height: 20),
Container(
width: double.infinity,
height: 180,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16),
gradient: LinearGradient(
colors: [Colors.blue.shade400, Colors.blue.shade700],
),
boxShadow: [
BoxShadow(
color: Colors.black26,
blurRadius: 8,
offset: Offset(0, 4),
),
],
),
child: Center(
child: Text(
"Mega Sale Today!",
 style: TextStyle(
fontSize: 22,
color: Colors.white,
fontWeight: FontWeight.bold,
),
),
),
),
SizedBox(height: 20),
Expanded(
child: ListView(
children: [
      _productCard("Product 1", "\$100", "https://picsum.photos/100"),
      _productCard("Product 2", "\$150", "https://picsum.photos/101"),
      _productCard("Product 3", "\$200", "https://picsum.photos/102"),
    ],
// Row(
// children: [
// ClipRRect(
// borderRadius: BorderRadius.circular(12),
// child: Image.network(
// "https://picsum.photos/100",
// width: 80,
// height: 80,
// fit: BoxFit.fill,
// ),
// ),
// SizedBox(width: 12),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "Product 1",
// style: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.bold,
// ),
// ),
// SizedBox(height: 6),
// Text(
// "\$100",
// style: TextStyle(
// fontSize: 16,
// color: Colors.green.shade700,
// fontWeight: FontWeight.w500,
// ),
// ),
// Row(
// children: [
// Icon(Icons.star, color: Colors.amber, size: 16),
// Icon(Icons.star, color: Colors.amber, size: 16),
// ],
// ),
// ],
// ),
// ],
// ),
// SizedBox(height: 12),
//   Row(
//     children: [
//       ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Image.network(
//       "https://picsum.photos/101",
//           width: 80,
//           height: 80,
//           fit: BoxFit.fill,
//         ),
//       ),
//       SizedBox(width: 12),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Product 2",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 6),
//           Text(
//             "\$150",
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.green.shade700,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Row(
//             children: [
//               Icon(Icons.star, color: Colors.amber, size: 16),
//               Icon(Icons.star, color: Colors.amber, size: 16),
//             ],
//           ),
//         ],
//       ),
//     ],
//   ),
//   SizedBox(height: 12),

//   Row(
//     children: [
//       ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Image.network(
//           "https://picsum.photos/102", width: 80, height: 80,

//           fit: BoxFit.fill,
//         ),
//       ),
//       SizedBox(width: 12),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Product 3",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 6),
//           Text(
//             "\$200",
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.green.shade700,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Row(
//             children: [
//               Icon(Icons.star, color: Colors.amber, size: 16),
//               Icon(Icons.star, color: Colors.amber, size: 16),
//             ],
//           ),
//         ],
//       ),
//     ],
//   ),


),
),
SizedBox(height: 20.h),
Row(
  children: [
    Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 3,
        ),
        onPressed: () {
          setState(() {
            cartcount++;
          });
        },
        icon: Icon(Icons.shopping_cart, size: 18.sp, color: Colors.white),
        label: Text(
          "Add to Cart",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
                      color: Colors.white,

          ),
        ),
      ),
    ),

    SizedBox(width: 12.w),

    Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 3,
        ),
        onPressed: () {
          setState(() {
            cartcount++;
          });
          },
        icon: Icon(Icons.card_travel_outlined, size: 18.sp, color: Colors.white),
        label: Text(
          "Buy Now",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ],
),

SizedBox(height: 20.h),

Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(vertical: 16.h),
  margin: EdgeInsets.only(top: 8.h),

  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.r),
    gradient: LinearGradient(
      colors: [
        Colors.orange.shade400,
        Colors.deepOrange,
      ],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.orange.withOpacity(.3),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  ),

  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.local_offer, color: Colors.white, size: 20.sp),
      SizedBox(width: 8.w),
      Text(
        "Special Offer: 10% OFF",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
  ),
),
       
],
),                            
),
),
);
}
Widget _productCard(String name, String price, String img) {
  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.network(
            img,
            width: 80.w,
            height: 80.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold)),

              SizedBox(height: 6.h),

              Text(price,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.green)),

              Row(
                children: [
                  Icon(Icons.star, size: 14.sp, color: Colors.amber),
                  Icon(Icons.star, size: 14.sp, color: Colors.amber),
                ],
              ),
            ],
          ),
        ),

        IconButton(
          icon: Icon(Icons.add_circle,
              color: Colors.blue, size: 26.sp),
          onPressed: () {
            setState(() {
              cartcount++;
            });
          },
        )
      ],
    ),
  );
}
}
