// import 'package:firebase_project_hotel_bookking/controller/details_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';

// class DetailsPage extends StatefulWidget {
//   final String image;
//   final String name;
//   final String price;

//   const DetailsPage({
//     super.key,
//     required this.image,
//     required this.name,
//     required this.price,
//   });

//   @override
//   State<DetailsPage> createState() => _DetailsPageState();
// }

// class _DetailsPageState extends State<DetailsPage> {
//  @override
// void initState() {
//   super.initState();

//   Future.microtask(() {
//     final provider =
//         Provider.of<DetailsController>(context, listen: false);

//     provider.init(widget.price); // always reset
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DetailsController>(context);

//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.only(top: 50.0, left: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             /// BACK
//             GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffef2b39),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: const Icon(Icons.arrow_back,
//                     size: 30.0, color: Colors.white),
//               ),
//             ),

//             const SizedBox(height: 10.0),

//             /// IMAGE
//             Center(
//               child: Image.asset(
//                 widget.image,
//                 height: MediaQuery.of(context).size.height / 3,
//                 fit: BoxFit.contain,
//               ),
//             ),

//             const SizedBox(height: 20.0),

//             Text(widget.name,
//                 style: Appwidgets.headlinetextfeildstyle()),

//             Text("\$${widget.price}",
//                 style: Appwidgets.pricetextfeildstyle()),

//             const SizedBox(height: 30.0),

//             Padding(
//               padding: const EdgeInsets.only(right: 10.0),
//               child: Text(
//                 "We've established that most cheeses will melt when baked atop pizza. But which will not only melt but stretch into those gooey strands?",
//                 style: Appwidgets.simpletextfeildstyle(),
//               ),
//             ),

//             const SizedBox(height: 30),

//             Text("quantity",
//                 style: Appwidgets.simpletextfeildstyle()),

//             const SizedBox(height: 10),

//             /// QUANTITY
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () =>
//                       provider.addQuantity(widget.price),
//                   child: Material(
//                     elevation: 3.0,
//                     borderRadius: BorderRadius.circular(10),
//                     child: Container(
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         color: const Color(0xffef2b39),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(Icons.add,
//                           color: Colors.white, size: 30.0),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 20),

//                 Text(
//                   provider.quantity.toString(),
//                   style: Appwidgets.headlinetextfeildstyle(),
//                 ),

//                 const SizedBox(width: 20),

//                 GestureDetector(
//                   onTap: () =>
//                       provider.removeQuantity(widget.price),
//                   child: Material(
//                     elevation: 3.0,
//                     borderRadius: BorderRadius.circular(10),
//                     child: Container(
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         color: const Color(0xffef2b39),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(Icons.remove,
//                           color: Colors.white, size: 30.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 40),

//             /// PRICE + ORDER BUTTON
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Material(
//                   elevation: 3,
//                   borderRadius: BorderRadius.circular(20),
//                   child: Container(
//                     height: 60,
//                     width: 120,
//                     decoration: BoxDecoration(
//                       color: const Color(0xffef2b39),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "\$${provider.toteprice}",
//                         style:
//                             Appwidgets.boldwhitetextfeildstyle(),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 30),

//                 GestureDetector(
//                   onTap: () {
//                     provider.placeOrder(
//                       context,
//                       widget.name,
//                       widget.image,
//                     );
//                   },
//                   child: Material(
//                     elevation: 3,
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       height: 70,
//                       width: 200,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "ORDER NOW",
//                           style: Appwidgets.whitetextfeildstyle(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }import 'package:firebase_project_hotel_bookking/controller/details_controller.dart';
import 'package:firebase_project_hotel_bookking/controller/details_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_project_hotel_bookking/core/constants/widget_support.dart';

class DetailsPage extends StatefulWidget {
  final String image;
  final String name;
  final String price;

  const DetailsPage({
    super.key,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider =
          Provider.of<DetailsController>(context, listen: false);

      provider.init(widget.price);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailsController>(context);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xffef2b39),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10.0),

            Center(
              child: Image.asset(
                widget.image,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 1.3,
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20.0),

            Text(
              widget.name,
              style: Appwidgets.headlinetextfeildstyle(),
            ),

            Text(
              "\$${widget.price}",
              style: Appwidgets.pricetextfeildstyle(),
            ),

            const SizedBox(height: 30.0),

            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                "We've established that most cheeses will melt when baked atop pizza. But which will not only melt but stretch into those gooey strands?",
                style: Appwidgets.simpletextfeildstyle(),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "quantity",
              style: Appwidgets.simpletextfeildstyle(),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                GestureDetector(
                  onTap: () => provider.addQuantity(widget.price),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  provider.quantity.toString(),
                  style: Appwidgets.headlinetextfeildstyle(),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => provider.removeQuantity(widget.price),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "\$${provider.toteprice}",
                        style: Appwidgets.boldwhitetextfeildstyle(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    provider.placeOrder(
                      context,
                      widget.name,
                      widget.image,
                    );
                  },
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "ORDER NOW",
                          style: Appwidgets.whitetextfeildstyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}