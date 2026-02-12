import 'package:boi_poka/explore/components/genre_card.dart';
import 'package:boi_poka/explore/recommended_book_card.dart';
import 'package:boi_poka/explore/viewmodel/explore_viewmodel.dart';
import 'package:boi_poka/models/genre.dart';
import 'package:boi_poka/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ExploreViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          // const GoogleMap(
          //   initialCameraPosition: CameraPosition(
          //     target: LatLng(23.7947, 90.4015), // Banani/Dhanmondi area
          //     zoom: 14,
          //   ),
          //   myLocationEnabled: true,
          //   zoomControlsEnabled: false,
          //   mapToolbarEnabled: false,
          // ),

          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildFloatingSearchBar()),

                //const SliverToBoxAdapter(child: SizedBox(height: 150)),

                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9F8F4),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildSectionHeader("Browse Genres"),
                        _buildGenreGrid(),
                        _buildSectionHeaderWithAction("Recommended for You", () {}),
                        SizedBox(
                          height: 300, // Height to accommodate cover + text
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            itemCount: viewModel.recommendedBooks.length,
                            itemBuilder: (context, index) {
                              return RecommendedBookCard(book: viewModel.recommendedBooks[index]);
                            },
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Bottom Preview Card (Optional, for when a pin is tapped)
          // const Positioned(
          //   bottom: 100,
          //   left: 20,
          //   right: 20,
          //   child: MapBookPreviewCard(),
          // ),
        ],
      ),
    );
  }

  Widget _buildSectionHeaderWithAction(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 30, 25, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B252F),
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              "See All",
              style: TextStyle(
                color: Color(0xFF1B4332),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 30, 25, 15),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0xFF1B4332), // Deep Forest
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B252F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreGrid() {
    // Using the list of Genres defined in the previous step
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.9,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GenreCard(genre: genres[index]);
        },
      ),
    );
  }

  Widget _buildFloatingSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by book, author or area",
                border: InputBorder.none,
              ),
            ),
          ),
          const VerticalDivider(indent: 12, endIndent: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune, color: BoipokaTheme.primaryGreen),
          ),
        ],
      ),
    );
  }

  final List<Genre> genres = [
    Genre(
      title: "Classic",
      subtitle: "কালজয়ী সাহিত্য",
      icon: Icons.book_rounded,
      bgColor: const Color(0xFFFFF7F2),
      iconColor: const Color(0xFFD4A017),
    ),
    Genre(
      title: "Fiction",
      subtitle: "কল্পকাহিনী",
      icon: Icons.menu_book_rounded,
      bgColor: const Color(0xFFF0F4F1),
      iconColor: const Color(0xFF1B4332),
    ),
    Genre(
      title: "Academic",
      subtitle: "শিক্ষামূলক",
      icon: Icons.school_rounded,
      bgColor: const Color(0xFFFFF2F2),
      iconColor: const Color(0xFFB23B3B),
    ),
    Genre(
      title: "Poetry",
      subtitle: "কবিতা",
      icon: Icons.edit_note_rounded,
      bgColor: const Color(0xFFFFF9F2),
      iconColor: const Color(0xFFB8860B),
    ),
  ];
}
