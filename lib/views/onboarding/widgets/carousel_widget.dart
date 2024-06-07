// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  List<String> images = [
    'assets/onboarding/welcome.svg',
    'assets/onboarding/weather.svg',
    'assets/onboarding/watering.svg',
    'assets/onboarding/planting.svg',
    'assets/onboarding/myplant.svg',
  ];
  List<Map<String, String>> captions = [
    {
      'title': 'Welcome to Plantopia',
      'subtitle':
          'Grow happiness with Plantopia! Welcome to a world where every leaf tells a life story.',
    },
    {
      'title': 'Weather Information',
      'subtitle':
          'Get the latest weather forecast to help you care for your plants '
    },
    {
      'title': 'Watering Reminder',
      'subtitle':
          "Never forget to water your plants again! We'll notify you when it's time to water"
    },
    {
      'title': 'Planting Instructions',
      'subtitle':
          "Follow easy step-by-step instructions for planting and nurturing your garden."
    },
    {
      'title': 'My Plant',
      'subtitle':
          "Easily manage your plant collection and monitor their progress with the 'My Plant'"
    },
  ];

  int activeIndex = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    void animateToSlide(int index) => controller.animateToPage(index);

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CarouselSlider.builder(
          carouselController: controller,
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            String image = images[index];
            Map<String, String> caption = captions[index];
            return _sectionWidget(index, image: image, caption: caption);
          },
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.60,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayCurve: Curves.linear,
              autoPlayInterval: const Duration(seconds: 10),
              // autoPlayAnimationDuration:
              //     const Duration(seconds: 5, milliseconds: 200),
              // enlargeCenterPage: true,
              enableInfiniteScroll: true,
              initialPage: 2,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index))),
      const SizedBox(
        height: 20.0,
      ),
      Column(
        children: [
          AnimatedSmoothIndicator(
            onDotClicked: animateToSlide,
            effect: const WormEffect(
                dotWidth: 8,
                dotHeight: 8,
                activeDotColor: Color(0xFF10B981),
                dotColor: Color(0xffD1D5DB),
                spacing: 8),
            activeIndex: activeIndex,
            count: images.length,
          )
        ],
      ),
    ]);
  }

  Widget _sectionWidget(int index,
      {required String image, required Map<String, String> caption}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 320,
          child: SvgPicture.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        _captionWidget(title: caption['title']!, subtitle: caption['subtitle']!)
      ],
    );
  }

  Widget _captionWidget({required String title, required String subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Text(
              textAlign: TextAlign.center,
              title,
              style: GoogleFonts.nunito(
                  color: const Color(0xFF030712),
                  fontSize: 23,
                  fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 5.0,
          ),
          Text(
              maxLines: 2,
              textAlign: TextAlign.center,
              subtitle,
              style: GoogleFonts.nunito(
                  color: const Color(0xFF6B7280),
                  fontSize: 16,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
