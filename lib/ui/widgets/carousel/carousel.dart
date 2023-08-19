import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_ecommerce/ui/constant/constant.dart';

class CarouselWidgetList extends StatefulWidget {
  final BorderRadiusGeometry? borderRadius;
  final double height;
  const CarouselWidgetList({
    super.key,
    this.borderRadius,
    this.height = 165,
  });

  @override
  State<CarouselWidgetList> createState() => _CarouselWidgetListState();
}

class _CarouselWidgetListState extends State<CarouselWidgetList> {
  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Stack(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              height: widget.height,
              autoPlay: true,
              enlargeCenterPage: false,
              aspectRatio: 1.0,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                currentIndex = index;
                setState(() {});
              },
            ),
            items: courlImage
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: widget.borderRadius,
                            image: DecorationImage(
                              image: NetworkImage(
                                value,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
                .values
                .toList(),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: courlImage
                  .asMap()
                  .map((index, value) => MapEntry(
                        index,
                        GestureDetector(
                          onTap: () => carouselController.animateToPage(index),
                          child: Container(
                            width: 12.0,
                            height: 6.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.white)
                                    .withOpacity(
                                        currentIndex == index ? 0.9 : 0.4)),
                          ),
                        ),
                      ))
                  .values
                  .toList(),
            ),
          ),
        ],
      );
    });
  }
}
