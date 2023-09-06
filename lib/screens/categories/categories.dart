
import 'package:flutter/material.dart';


class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Map<String, dynamic>> categories=[
    {"image":"assets/category/fruit.jpg","text":"Fruits"},
    {"image":"assets/category/roughages.jpg","text":"Roughages"},
    {"image":"assets/category/grain.jpg","text":"Grain"},
    {"image":"assets/category/greens.jpg","text":"Vegetables"},
    {"image":"assets/category/herbs.jpg","text":"Herbs"},
    {"image":"assets/category/meals.jpg","text":'Meals'},
    {"image":"assets/category/meat.jpg","text":"Meat"},
    {"image":"assets/category/oil.jpg","text":"Oil"},
    {"image":" assets/category/tubers.jpg","text":"Tubers"},

  ];
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            ...List.generate(categories.length, (index) => Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: CategoryCard(
                  image: categories[index]['image'],
                  text: categories[index]['text'],
                  press: (){}),
            )
            ),


          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String image,text;
  final GestureTapCallback press;
  const CategoryCard({super.key, required this.image, required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 40,
              width:  60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(image,
                fit: BoxFit.cover,),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(text,
            textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}

