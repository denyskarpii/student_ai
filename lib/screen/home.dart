import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_ai/screen/chat_screen.dart';
import 'package:student_ai/screen/form.dart';
import 'package:student_ai/widgets/api_input.dart';
import 'package:student_ai/widgets/card_widget.dart';
import 'package:student_ai/widgets/search_bar.dart';

import '../data/card_data.dart';
import '../data/constants.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: kPurple,
        foregroundColor: kWhite,
        centerTitle: true,
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              width: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "StudentAI",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ApiInput();
                },
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "What's New to Learn",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SearchBar(
            color: kBlack,
            chatController: chatController,
            onTap: () {
              if (chatController.text.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      querycontroller: chatController,
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Apps for You",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: cardAspectRatio,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: cardData.length,
              itemBuilder: (context, index) {
                final data = cardData[index];
                return CardWidget(
                  id: data['id'],
                  data: data,
                  pageRoute: MyForm(id: data['id'], title: data['title']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}