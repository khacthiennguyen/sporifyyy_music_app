import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sporifyyy/common/helpers/is_dark_mode.dart';
import 'package:sporifyyy/common/widgets/appbar/app_bar.dart';
import 'package:sporifyyy/core/configs/assets/app_images.dart';
import 'package:sporifyyy/core/configs/assets/app_vectors.dart';
import 'package:sporifyyy/core/configs/theme/app_colors.dart';
import 'package:sporifyyy/presentation/home/widgets/news_songs.dart';
import 'package:sporifyyy/presentation/home/widgets/play_list.dart';
import 'package:sporifyyy/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
          hindenBack: true,
          action: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              icon: Icon(Icons.person)),
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 40,
            width: 40,
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tab(),
            SizedBox(
              height: 200,
              child: TabBarView(
                controller: _tabController,
                children: [
                  NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            const PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.homeTopCard)),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Image.asset(AppImages.homeArtist),
                ))
          ],
        ),
      ),
    );
  }

  Widget _tab() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      child: TabBar(
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        indicatorColor: AppColors.primary,
        dividerColor: Colors.transparent,
        controller: _tabController,
        isScrollable: true,
        tabs: const [
          Text(
            "News",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          ),
          Text(
            "Videos",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          ),
          Text(
            "Artists",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          ),
          Text(
            "PodCast",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
