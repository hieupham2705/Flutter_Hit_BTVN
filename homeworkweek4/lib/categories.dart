import 'package:flutter/material.dart';
import 'package:homeworkweek4/data.dart';
import 'listfood.dart';
class Categories extends StatefulWidget {
  static const String routeName = '/';
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late List<Category> listCaregories;
  @override
  void initState() {
    listCaregories = DUMMY_CATEGORIES;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF272A32),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bgr.png'),
              fit: BoxFit.fill
            )
          ),
          child: GridView.builder(
            itemCount: listCaregories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return ItemListCategori(category: listCaregories[index],);
            },
          ),
        )
    );
  }
}

class ItemListCategori extends StatelessWidget {
  final Category category;

  const ItemListCategori(
      {super.key, required this.category, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ListFood.routeName, arguments: category);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          category.title,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
