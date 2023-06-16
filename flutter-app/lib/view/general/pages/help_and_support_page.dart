import 'package:carvice_frontend/widgets/alerts_text_button.dart';
import 'package:carvice_frontend/widgets/button.dart';
import 'package:carvice_frontend/widgets/custom_app_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_navigation.dart';
import '../../../widgets/dropdown_question.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({Key? key, required this.isClient}) : super(key: key);
  final bool isClient;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqList = isClient
        ? [
      {
        'question': 'What is Carvice Made for?',
        'answer': 'Carvice is made for helping you defiling with any issue related with your car by giving you the opportunity '
            'to request an immediate help from our mechanics where ever you are!',
      },
      {
        'question': 'How can I make a request',
        'answer': 'Our customer Can easily request a help by pressing on the help icon in the home page and following the instructions ',
      },
      {
        'question': 'Is your Service paid?',
        'answer': 'We are offering a free services for our customer which is finding the closest mechanic and paying throw our application making sure that the our users will have a good experience.',
      },
      {
        'question': 'How can you find me?',
        'answer': 'After pressing on the help button our application will request a permission to access the user location and get their current address to send them the fastest help.',
      },
      {
        'question': 'How Do you know my car information?',
        'answer': 'In order to make a request and ask for help our users must add their car information by going to my cars page in the sidebar or in the user section so this information can be send to the mechanic to help him',
      },
      {
        'question': 'Can I add more than one car?',
        'answer': 'You may add any number of cars to your cars list and you can chose which car you want to get help with once you press on the request button',
      },
      {
        'question': 'Can I update my car information',
        'answer': 'Yes!, Our users can easily updates their car information by pressing on the car in their car list page and make any changes they want easily',
      },
      {
        'question': 'Can I update my profile information',
        'answer': 'Yes!, Our users can easily updates their profile information by pressing on the update profile button in their user page and make any changes they want easily',
      },
    ]
        : [
      {
        'question': 'How Carvice will survey me as a mechanic?',
        'answer': 'We will help make your workshop more accessible and faster, and you will get a large number of customers',
      },
      {
        'question': 'How my clients will pay me?',
        'answer': 'Upon approval of the client\'s request, the professional amount will be transferred to the wallet and suspended until the end of the service, then transferred to the mechanic',
      },
      {
        'question': 'Can I update my profile information',
        'answer': 'Yes!, Our users can easily updates their profile information by pressing on the update profile button in their user page and make any changes they want easily',
      },
      {
        'question': 'Can I update my address information',
        'answer': 'Yes!, Our users can easily updates their address information by pressing on my address button in their user page and make any changes they want easily',
      },
      {
        'question': 'Why sharing an address is a must?',
        'answer': 'The mechanic must share his correct workshop address to enable our software to help him find customers near his location',
      },
    ];

    return Scaffold(
      appBar: const AppNavigation(title: 'Help And Support', automaticallyCallBack: true),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                return DropdownWidget(
                  question: faqList[index]['question']!,
                  answer: faqList[index]['answer']!,
                );
              },
            ),
          ),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Can\'t find your answer?' ,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
            child: CustomButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Contact Us'),
                      content: const Text('Please for any farther question do not hesitate to contact us on:\n \n Carviceapp@gmail.com'),
                      actions: [
                        CustomAlertButton(
                          text: 'close'.tr,
                          onPressed: () {
                            Navigator.of(context).pop();
                            },
                        )
                      ],
                    );
                  },
                );
              },
              btnText: 'Contact Us :)',
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomFooterWidget(),
    );
  }
}
