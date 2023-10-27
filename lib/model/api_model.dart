// To parse this JSON data, do
//
//     final apiModel = apiModelFromJson(jsonString);

import 'dart:convert';

List<ApiModel> apiModelFromJson(String str) =>
    List<ApiModel>.from(json.decode(str).map((x) => ApiModel.fromJson(x)));

class ApiModel {
  String? restaurantId;
  String? restaurantName;
  String? restaurantImage;
  String? tableId;
  String? tableName;
  String? branchName;
  String? nexturl;
  List<TableMenuList>? tableMenuList;

  ApiModel({
    this.restaurantId,
    this.restaurantName,
    this.restaurantImage,
    this.tableId,
    this.tableName,
    this.branchName,
    this.nexturl,
    this.tableMenuList,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        restaurantId: json["restaurant_id"],
        restaurantName: json["restaurant_name"],
        restaurantImage: json["restaurant_image"],
        tableId: json["table_id"],
        tableName: json["table_name"],
        branchName: json["branch_name"],
        nexturl: json["nexturl"],
        tableMenuList: json["table_menu_list"] == null
            ? []
            : List<TableMenuList>.from(
                json["table_menu_list"]!.map((x) => TableMenuList.fromJson(x))),
      );
}

class TableMenuList {
  String? menuCategory;
  String? menuCategoryId;
  String? menuCategoryImage;
  String? nexturl;
  List<CategoryDish>? categoryDishes;

  TableMenuList({
    this.menuCategory,
    this.menuCategoryId,
    this.menuCategoryImage,
    this.nexturl,
    this.categoryDishes,
  });

  factory TableMenuList.fromJson(Map<String, dynamic> json) => TableMenuList(
        menuCategory: json["menu_category"],
        menuCategoryId: json["menu_category_id"],
        menuCategoryImage: json["menu_category_image"],
        nexturl: json["nexturl"],
        categoryDishes: json["category_dishes"] == null
            ? []
            : List<CategoryDish>.from(
                json["category_dishes"]!.map((x) => CategoryDish.fromJson(x))),
      );
}

class AddonCat {
  String? addonCategory;
  String? addonCategoryId;
  int? addonSelection;
  String? nexturl;
  List<CategoryDish>? addons;

  AddonCat({
    this.addonCategory,
    this.addonCategoryId,
    this.addonSelection,
    this.nexturl,
    this.addons,
  });

  factory AddonCat.fromJson(Map<String, dynamic> json) => AddonCat(
        addonCategory: json["addon_category"],
        addonCategoryId: json["addon_category_id"],
        addonSelection: json["addon_selection"],
        nexturl: json["nexturl"],
        addons: json["addons"] == null
            ? []
            : List<CategoryDish>.from(
                json["addons"]!.map((x) => CategoryDish.fromJson(x))),
      );
}

class CategoryDish {
  String? dishId;
  String? dishName;
  double? dishPrice;
  String? dishImage;
  String? dishCurrency;
  double? dishCalories;
  String? dishDescription;
  bool? dishAvailability;
  int? dishType;
  int itemCount;
  String? nexturl;
  List<AddonCat>? addonCat;

  CategoryDish({
    this.dishId,
    this.dishName,
    this.dishPrice,
    this.dishImage,
    this.dishCurrency,
    this.dishCalories,
    this.dishDescription,
    this.dishAvailability,
    this.itemCount = 0,
    this.dishType,
    this.nexturl,
    this.addonCat,
  });

  CategoryDish copyWith({
    String? dishId,
    String? dishName,
    double? dishPrice,
    String? dishImage,
    String? dishCurrency,
    double? dishCalories,
    String? dishDescription,
    bool? dishAvailability,
    int? dishType,
    int? itemCount,
    String? nexturl,
    List<AddonCat>? addonCat,
  }) {
    return CategoryDish(
      dishId: dishId ?? this.dishId,
      dishName: dishName ?? this.dishName,
      dishPrice: dishPrice ?? this.dishPrice,
      dishImage: dishImage ?? this.dishImage,
      dishCurrency: dishCurrency ?? this.dishCurrency,
      dishCalories: dishCalories ?? this.dishCalories,
      dishDescription: dishDescription ?? this.dishDescription,
      dishAvailability: dishAvailability ?? this.dishAvailability,
      dishType: dishType ?? this.dishType,
      itemCount: itemCount ?? this.itemCount,
      nexturl: nexturl ?? this.nexturl,
      addonCat: addonCat ?? this.addonCat,
    );
  }

  factory CategoryDish.fromJson(Map<String, dynamic> json) => CategoryDish(
        dishId: json["dish_id"],
        dishName: json["dish_name"],
        dishPrice: json["dish_price"]?.toDouble() * 22.19,
        dishImage: json["dish_image"],
        dishCurrency: json["dish_currency"],
        dishCalories: json["dish_calories"],
        dishDescription: json["dish_description"],
        dishAvailability: json["dish_Availability"],
        dishType: json["dish_Type"],
        nexturl: json["nexturl"],
        addonCat: json["addonCat"] == null
            ? []
            : List<AddonCat>.from(
                json["addonCat"]!.map((x) => AddonCat.fromJson(x))),
      );
}
