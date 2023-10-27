import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:levelx_interview/providers/cart_provider.dart';
import 'package:levelx_interview/providers/provider.dart';
import 'package:levelx_interview/screens/checkout_screen.dart';
import 'package:levelx_interview/service/auth_service.dart';
import 'package:levelx_interview/utils/responsive.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ref.watch(cartProvider).cartList;
    return ref.watch(apiProvider).when(
      data: (data) {
        if (data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var category = data[0].tableMenuList;
        return DefaultTabController(
          length: category!.length,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.black54,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckoutScreen(),
                          ));
                    },
                    icon: Stack(alignment: Alignment.topRight, children: [
                      const Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          '${ref.watch(cartProvider).cartList.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ]))
              ],
              bottom: TabBar(
                  labelPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.red,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  indicatorColor: Colors.red,
                  indicatorWeight: 2.7,
                  isScrollable: true,
                  tabs: [
                    for (int i = 0; i < category.length; i++)
                      Text("${category[i].menuCategory}"),
                  ]),
            ),
            drawer: Drawer(
              width: R.rw(360, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: R.rh(240, context),
                    width: R.rw(360, context),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 20, 153, 24),
                          Color.fromARGB(255, 33, 237, 40),
                        ]),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: R.rw(32, context),
                          backgroundImage: NetworkImage(
                            ref.watch(userDataProvider)!.photoURL ??
                                "https://icons.veryicon.com/png/o/internet--web/55-common-web-icons/person-4.png",
                          ),
                        ),
                        SizedBox(
                          height: R.rh(20, context),
                        ),
                        Text(
                          '${ref.watch(userDataProvider)!.displayName ?? ref.watch(userDataProvider)!.phoneNumber}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: R.rh(10, context),
                        ),
                        Text(
                          'ID : ${ref.watch(userDataProvider)!.uid}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: R.rh(10, context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: R.rw(10, context)),
                    child: TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                        ),
                        onPressed: () async {
                          await AuthService().signOut();
                          await GoogleSignIn().signOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 34,
                        ),
                        label: Padding(
                          padding: EdgeInsets.only(left: R.rw(24, context)),
                          child: const Text(
                            "Log out",
                            style: TextStyle(fontSize: 22),
                          ),
                        )),
                  )
                ],
              ),
            ),
            body: TabBarView(children: [
              for (int page = 0; page < category.length; page++)
                ListView.separated(
                  itemCount: category[page].categoryDishes!.length,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 2,
                  ),
                  itemBuilder: (context, index) {
                    var productCount = ref.watch(cartProvider).itemcount(
                        category[page].categoryDishes![index].dishId!);
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: category[page]
                                              .categoryDishes![index]
                                              .dishType ==
                                          2
                                      ? Colors.green
                                      : Colors.red),
                            ),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: category[page]
                                          .categoryDishes![index]
                                          .dishType ==
                                      2
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: R.rw(260, context),
                                child: Text(
                                  "${category[page].categoryDishes![index].dishName}",
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: R.rh(4, context),
                              ),
                              SizedBox(
                                width: R.rw(270, context),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "INR ${category[page].categoryDishes![index].dishPrice!.toInt()}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${category[page].categoryDishes![index].dishCalories!.toInt()} calories",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: R.rh(10, context),
                              ),
                              SizedBox(
                                width: R.rw(270, context),
                                child: Text(
                                  "${category[page].categoryDishes![index].dishDescription}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: R.rh(10, context),
                              ),
                              Container(
                                height: R.rh(35, context),
                                width: R.rw(120, context),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          if (productCount != null &&
                                              productCount > 0) {
                                            ref
                                                .read(
                                                    itemCountProvider.notifier)
                                                .state--;
                                          }
                                          ref
                                              .read(cartProvider.notifier)
                                              .removefromcart(category[page]
                                                  .categoryDishes![index]);
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      "${productCount ?? category[page].categoryDishes![index].itemCount}",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          ref
                                              .read(itemCountProvider.notifier)
                                              .state++;
                                          ref
                                              .read(cartProvider.notifier)
                                              .addtocart(category[page]
                                                  .categoryDishes![index]);
                                        },
                                        icon: const Icon(Icons.add,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              category[page]
                                      .categoryDishes![index]
                                      .addonCat!
                                      .isNotEmpty
                                  ? const Text(
                                      'Customizations Available',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: R.rh(8, context),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: R.rh(65, context),
                              width: R.rw(60, context),
                              child: Image.asset(
                                "assets/salad.jpg",
                                fit: BoxFit.cover,
                              ))
                        ],
                      ),
                    );
                  },
                ),
            ]),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
