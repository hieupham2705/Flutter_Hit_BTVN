import 'package:flutter/material.dart';
import 'package:homeworkweek4/data.dart';
import 'fooddetail.dart';

class ListFood extends StatefulWidget {
  const ListFood({super.key});

  static const String routeName = '/first';

  @override
  State<ListFood> createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {
  late Category category;
  late List<Meal> listFood = [];

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context)!.settings.arguments as Category;
    List<Meal> tmpList = DUMMY_MEALS;
    tmpList.forEach((element) {
      if (element.categories.contains(category.id)) {
        listFood.add(element);
        print('object');
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF272A32),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bgr.png'), fit: BoxFit.cover)),
        child: GridView.builder(
          itemCount: listFood.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 420, crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return ItemListFood(
              food: listFood[index],
            );
          },
        ),
      ),
    );
  }
}

class ItemListFood extends StatelessWidget {
  final Meal food;

  const ItemListFood({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, FoodDetail.routeName, arguments: food);
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF353842)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 80,
              backgroundImage: NetworkImage(
                food.imageUrl,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(food.title,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Expanded(
                          child: Icon(
                            Icons.monetization_on,
                            color: Color(0xFF686F82),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          food.affordability.name,
                          style: const TextStyle(color: Color(0xFF686F82)),
                        )
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Expanded(
                        child: Icon(Icons.timelapse, color: Color(0xFF686F82)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        food.duration.toString(),
                        style: const TextStyle(color: Color(0xFF686F82)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                food.complexity.name,
                style: const TextStyle(
                    color: Color(0xFFFF7269),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
