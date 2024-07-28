import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();  // Initialize ScrollController

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Fashion Times'),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              DrawerHeader(
                child: Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                child: Wrap(
                  spacing: 8.0,
                  children: dataProvider.selectedFilters.entries
                      .expand((entry) => entry.value.map((value) => FilterChip(
                            label: Text(value),
                            selected: true,
                            onSelected: (selected) {
                              if (!selected) {
                                dataProvider.toggleFilter(entry.key, value);
                              }
                            },
                          )))
                      .toList(),
                ),
              ),
              FilterDropdown(
                title: 'Brand',
                options: ['Brand A', 'Brand B', 'Brand C'],
              ),
              FilterDropdown(
                title: 'Color',
                options: ['Red', 'Blue', 'Green'],
              ),
              FilterDropdown(
                title: 'Size',
                options: ['S', 'M', 'L', 'XL'],
              ),
              FilterDropdown(
                title: 'Price Range',
                options: ['\$0 - \$50', '\$50 - \$100', '\$100 - \$200'],
              ),
              FilterDropdown(
                title: 'Material',
                options: ['Cotton', 'Polyester', 'Wool'],
              ),
              FilterDropdown(
                title: 'Type',
                options: ['T-Shirts', 'Jeans', 'Dresses'],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CardSwiper(
                controller: CardSwiperController(),
                allowedSwipeDirection: const AllowedSwipeDirection.symmetric(horizontal: true),
                numberOfCardsDisplayed: 3,
                cardsCount: dataProvider.products.length,
                cardBuilder: (BuildContext context, int index, int horizontalOffsetPercentage, int verticalOffsetPercentage) {
                  final product = dataProvider.products[index];
                  
                  // Reset scroll position when a new card is displayed
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (scrollController.hasClients) {
                      scrollController.jumpTo(0);
                    }
                  });
                  
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 15.0), // Adjusted padding
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: SingleChildScrollView(
                          controller: scrollController, // Attach ScrollController
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
                      // Logic for swipe none
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

  FilterDropdown({
    required this.title,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjusted padding
      child: ExpansionTile(
        title: Text(title),
        children: options.map((String option) {
          return CheckboxListTile(
            title: Text(option),
            value: dataProvider.selectedFilters[title]?.contains(option) ?? false,
            onChanged: (bool? value) {
              dataProvider.toggleFilter(title, option);
            },
          );
        }).toList(),
      ),
    );
  }
}
