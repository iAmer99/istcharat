import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:istchrat/screens/main/models/home_model.dart';
import 'package:istchrat/screens/main/widgets/slider_item.dart';
import 'package:istchrat/shared_components/colors.dart';

class ImageSlider extends StatefulWidget {
  final List<Sliders>? sliders;

  const ImageSlider({Key? key, this.sliders}) : super(key: key);
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              CarouselSlider(
                items: widget.sliders?.map((item) {
                  return SliderItem(
                    slider: item,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 180,
                  disableCenter: true,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 1200),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, _) =>
                      setState(() => currentIndex = index),
                ),
              ),
              Positioned(
                bottom: 2 * 7,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.sliders!.map((url) {
                    int index = widget.sliders!.indexOf(url);
                    return Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index ? Colors.blue : grey,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 2 * 7,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDot(),
              buildDot(),
              buildDot(),
            ],
          ),
        ),
      ],
    );
  }

  Container buildDot() {
    return Container(
      width: 20.w,
      height: 0.h,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}
