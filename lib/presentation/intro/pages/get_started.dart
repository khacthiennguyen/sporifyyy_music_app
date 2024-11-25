import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sporifyyy/common/widgets/button/basic_app_buton.dart';
import 'package:sporifyyy/core/configs/assets/app_images.dart';
import 'package:sporifyyy/core/configs/assets/app_vectors.dart';
import 'package:sporifyyy/presentation/choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            decoration: const BoxDecoration(
              // ignore: unnecessary_const
              image: const DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(AppImages.intro_BG)),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.15)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                const Spacer(),
                const Text(
                  "Enjoy Listening to Music",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 21,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  "Lorem ipsum dolor sit amet,consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 13),
                ),
                const SizedBox(
                  height: 20,
                ),
                BasicAppButon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChooseModePage()));
                    },
                    title: "Get Started"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
