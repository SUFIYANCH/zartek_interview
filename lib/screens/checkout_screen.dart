import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:levelx_interview/model/api_model.dart';
import 'package:levelx_interview/providers/cart_provider.dart';
import 'package:levelx_interview/providers/provider.dart';
import 'package:levelx_interview/utils/responsive.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    log("build called");
    List<CategoryDish> categoryDishList = ref.watch(cartProvider).cartList;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black54,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text("Order Summary"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: R.rw(16, context), vertical: R.rh(10, context)),
          child: categoryDishList.isEmpty
              ? const Center(
                  child: Text("Cart is Empty"),
                )
              : Column(
                  children: [
                    Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(3),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF063B08),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "${categoryDishList.length} Dishes - ${ref.watch(itemCountProvider)} Items",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: R.rh(10, context),
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: categoryDishList.length,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                    top: R.rh(20, context),
                                    bottom: R.rh(20, context)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                        ),
                                        child: const CircleAvatar(
                                          radius: 5,
                                          backgroundColor: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        width: R.rw(120, context),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${categoryDishList[index].dishName}",
                                              style: const TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: R.rh(8, context),
                                            ),
                                            Text(
                                              "INR ${categoryDishList[index].dishPrice!.toInt()}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: R.rh(4, context),
                                            ),
                                            Text(
                                              "${categoryDishList[index].dishCalories!.toInt()} calories",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: R.rh(32, context),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color(0xFF063B08)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  ref
                                                      .read(itemCountProvider
                                                          .notifier)
                                                      .state--;

                                                  ref
                                                      .read(
                                                          cartProvider.notifier)
                                                      .removefromcart(
                                                          categoryDishList[
                                                              index]);
                                                },
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 22,
                                                )),
                                            Text(
                                              "${categoryDishList[index].itemCount}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  ref
                                                      .read(itemCountProvider
                                                          .notifier)
                                                      .state++;
                                                  ref
                                                      .read(
                                                          cartProvider.notifier)
                                                      .addtocart(
                                                          categoryDishList[
                                                              index]);
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 22,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "INR ${categoryDishList[index].dishPrice!.toInt() * (categoryDishList[index].itemCount)}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                thickness: 2,
                                endIndent: 8,
                                indent: 8,
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              endIndent: 8,
                              indent: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: R.rw(10, context),
                                  vertical: R.rh(8, context)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Amount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  Text(
                                    'INR ${ref.watch(cartProvider.notifier).toSum()}',
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF063B08),
                          shape: const StadiumBorder(),
                          fixedSize:
                              Size(R.rw(375, context), R.rh(50, context)),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: R.rw(100, context),
                                      width: R.rw(100, context),
                                      child: Image.asset(
                                        'assets/ordersuccess.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: R.rh(20, context),
                                    ),
                                    const Text(
                                      "Order successfully placed",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ],
                                ),
                                actions: [
                                  Center(
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF063B08),
                                            foregroundColor: Colors.white),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          ref
                                              .read(itemCountProvider.notifier)
                                              .state = 0;
                                          ref
                                              .read(cartProvider.notifier)
                                              .cartList
                                              .clear();
                                          ref.invalidate(cartProvider);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Back to Home')),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Place Order',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
        ));
  }
}
