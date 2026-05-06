import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/profile/view/widgets/Header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/riverpod/user_provider.dart';
import 'package:flutter_application_1/constants/app_images.dart';
import 'package:flutter_application_1/constants/colors.dart';

import 'package:flutter_application_1/screens/profile/modal/modal.dart';
import 'package:go_router/go_router.dart';

List<Map<String, dynamic>> profileData = [
  {
    "title": "Account Settings",
    "items": [
      {"name": "My kundli", "icon": Icons.list, 'screen': 'my-kundli'},
      {
        "name": "Order History",
        "icon": Icons.history,
        'screen': 'order-history',
      },
      {
        "name": "My details",
        "icon": Icons.person_outline,
        'screen': 'my-details',
      },
      {
        "name": "Saved Profile",
        "icon": Icons.group_outlined,
        'screen': 'saved-profile',
      },
      {"name": "Change language", "icon": Icons.language},
    ],
  },
  {
    "title": "Legal & Privacy",
    "items": [
      {
        "name": "Terms & Conditions",
        "icon": Icons.description_outlined,
        'screen': 'terms-condition',
      },
      {
        "name": "Privacy policy",
        "icon": Icons.privacy_tip_outlined,
        'screen': 'privacy-policy',
      },
    ],
  },
  {
    "title": "Account Actions",
    "items": [
      {"name": "Delete", "icon": Icons.delete_outline},
    ],
  },
];

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final userLanguage = ref.watch(userProvider).userLanguage;

    void handleLanguage(String lang) {
      ref.read(userProvider.notifier).setUserLanguage(lang);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
           
           Header(),
            ListView.builder(
              itemBuilder: (context, index) {
                final section = profileData[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        section['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...List.generate(section['items'].length, (itemIndex) {
                      final item = section['items'][itemIndex];
                      return ListTile(
                        // enabled: false,
                        enableFeedback: false,
                        leading: Icon(item['icon']),
                        title: Text(item['name']),
                        trailing: item['name'] == 'Change language'
                            ? Container(
                                // height: 100,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  // borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /// 🔹 EN Button
                                    GestureDetector(
                                      onTap: () => handleLanguage('en'),
                                      child: Container(
                                        width: 40,
                                        height: 35,

                                        decoration: BoxDecoration(
                                          color: userLanguage == 'en'
                                              ? GlobalColor.primary
                                              : Colors.white,
                                          border: Border.all(
                                            color: userLanguage == 'en'
                                                ? GlobalColor.primary
                                                : Colors.grey.shade300,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'EN',
                                            style: TextStyle(
                                              color: userLanguage == 'en'
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // const SizedBox(width: 10),

                                    /// 🔹 HI Button
                                    GestureDetector(
                                      onTap: () => handleLanguage('hi'),
                                      child: Container(
                                        width: 40,
                                        height: 35,

                                        decoration: BoxDecoration(
                                          color: userLanguage == 'hi'
                                              ? GlobalColor.primary
                                              : Colors.white,
                                          border: Border.all(
                                            color: userLanguage == 'hi'
                                                ? GlobalColor.primary
                                                : Colors.grey.shade300,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'हि',
                                            style: TextStyle(
                                              color: userLanguage == 'hi'
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  if (item['screen'] != null) {
                                    context.push('/profile/${item['screen']}');
                                  }
                                },
                              ),
                        // onTap: () {
                        //   if (item['name'] == 'Change language') {}
                        // },
                      );
                    }),
                  ],
                );
              },
              itemCount: profileData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
