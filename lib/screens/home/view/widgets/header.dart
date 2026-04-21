import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/app_images.dart';
import 'package:flutter_application_1/screens/home/model/model.dart';

List<HeaderItem> headerItemList(Map<String, dynamic> string) {
  return [
    HeaderItem(
      id: 1,
      label: string['Horoscope'] ?? '',
      image: AppImages.horoscope,
      width: 31,
      height: 24,
      screen: 'HoroscopeScreen',
      navigate: true,
    ),
    HeaderItem(
      id: 2,
      label: string['Panchang'] ?? '',
      image: AppImages.panchang,
      width: 28,
      height: 28,
      screen: 'PanchangScreen',
      navigate: true,
    ),
    HeaderItem(
      id: 3,
      label: string['Partner'] ?? '',
      image: AppImages.partner,
      width: 28,
      height: 28,
      screen: 'MatchMakingScreen',
      navigate: false,
    ),
    HeaderItem(
      id: 4,
      label: string['Kundli'] ?? '',
      image: AppImages.kundli,
      width: 22,
      height: 24,
      screen: 'KundliScreen',
      navigate: false,
    ),
  ];
}

class Header extends StatelessWidget {
  final Map<String, dynamic> string;

  const Header({super.key, required this.string});

  @override
  Widget build(BuildContext context) {
    final items = headerItemList(string);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(AppImages.swastikHome, height: 30, width: 30),
                    const SizedBox(width: 8),
                    Image.asset(AppImages.viranchiText, height: 25),
                  ],
                ),
              ),
              Image.asset(AppImages.bell, height: 30),
            ],
          ),
        ),

        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return GestureDetector(
                onTap: () {
                  if (item.navigate) {
                    Navigator.pushNamed(context, item.screen);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item.image,
                        width: item.width,
                        height: item.height,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.label,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}