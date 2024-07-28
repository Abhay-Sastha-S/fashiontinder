import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Discover Your Style',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterDropdown(
                    title: 'Brand',
                    options: ['Brand A', 'Brand B', 'Brand C'],
                    onChanged: (value) {
                      // Handle brand filter change
                    },
                  ),
                  FilterDropdown(
                    title: 'Color',
                    options: ['Red', 'Blue', 'Green'],
                    onChanged: (value) {
                      // Handle color filter change
                    },
                  ),
                  FilterDropdown(
                    title: 'Size',
                    options: ['S', 'M', 'L', 'XL'],
                    onChanged: (value) {
                      // Handle size filter change
                    },
                  ),
                  FilterDropdown(
                    title: 'Price Range',
                    options: ['\$0 - \$50', '\$50 - \$100', '\$100 - \$200'],
                    onChanged: (value) {
                      // Handle price range filter change
                    },
                  ),
                  FilterDropdown(
                    title: 'Material',
                    options: ['Cotton', 'Polyester', 'Wool'],
                    onChanged: (value) {
                      // Handle material filter change
                    },
                  ),
                  FilterDropdown(
                    title: 'Type',
                    options: ['T-Shirts', 'Jeans', 'Dresses'],
                    onChanged: (value) {
                      // Handle type of clothing filter change
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: CardSwiper(
          controller: CardSwiperController(),
          allowedSwipeDirection: const AllowedSwipeDirection.symmetric(horizontal: true),
          numberOfCardsDisplayed: 3,
          cardsCount: dataProvider.products.length,
          cardBuilder: (BuildContext context, int index, int horizontalOffsetPercentage, int verticalOffsetPercentage) {
            final product = dataProvider.products[index];
            return Padding(
              //padding: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10, 15),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          product.images[0],
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        for (int i = 1; i < product.images.length; i++)
                          Image.network(
                            product.images[i],
                            fit: BoxFit.cover,
                            height: 300,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(product.description),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          onSwipe: (int previousIndex, int? currentIndex, CardSwiperDirection direction) async {
            // Define your business logic for each swipe direction
            switch (direction) {
              case CardSwiperDirection.left:
                // Logic for swipe left
                print("Swiped left");
                break;
              case CardSwiperDirection.right:
                // Logic for swipe right
                print("Swiped right");
                break;
              case CardSwiperDirection.top:
                // Logic for swipe up
                print("Swiped up");
                break;
              case CardSwiperDirection.bottom:
                // Logic for swipe down
                print("Swiped down");
                break;
                case CardSwiperDirection.none:
                // Logic for swipe down
                print("Swiped none");
                break;
            }
            dataProvider.onCardSwiped(currentIndex ?? previousIndex, direction);
            return true;
          },
          onEnd: () async {
            print("No more cards");
          },
          onTapDisabled: () async {
            print("Tap disabled");
          },
          onUndo: (int? previousIndex, int currentIndex, CardSwiperDirection direction) {
            print("Undo swipe");
            return true;
          },
        ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterDropdown extends StatelessWidget {
  final String title;
  final List<String> options;
  final Function(String?) onChanged;

  FilterDropdown({
    required this.title,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: onChanged,
            hint: Text('Select $title'),
          ),
        ],
      ),
    );
  }
}
