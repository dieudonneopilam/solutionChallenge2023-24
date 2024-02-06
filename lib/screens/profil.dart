import 'package:flutter/material.dart';
import 'package:solutionchallenge2024/widgets/box.cnt.post.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 50,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          collapseMode: CollapseMode.pin,
          titlePadding: const EdgeInsets.all(10),
          title: const TextMedium('Profil page'),
          background: Image.asset('assets/img/default.png', fit: BoxFit.cover),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height10(),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/img/default.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: TextMedium('Dieudonne Ngwangwa'),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: TextSmall('dieudoneopilam2@gmail.com'),
              ),
              TabBar(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                indicatorColor: Colors.blue,
                controller: tabController,
                tabs: const [
                  TextMedium('Post', size: 16),
                  TextMedium('comments', size: 16),
                  TextMedium(
                    'Likes',
                    size: 16,
                  ),
                  TextMedium('views', size: 16)
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height - 380,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) => const BoxContentPost(),
                    ),
                    const TextMedium('Comment', size: 16),
                    const TextMedium('Likes'),
                    const TextMedium('Likes'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
