import 'package:boi_poka/home/components/book_listing_card.dart';
import 'package:boi_poka/home/components/small_book_card.dart';
import 'package:boi_poka/home/viewmodel/home_view_model.dart';
import 'package:boi_poka/home/widgets/request_card.dart';
import 'package:boi_poka/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.status == HomeStatus.loading) {
              return const Center(child: CircularProgressIndicator(color: BoipokaTheme.primaryGreen));
            }

            return CustomScrollView(
              slivers: [
                // 1. Top Section: Greeting & Search
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 20),
                        _buildSearchBar(viewModel),
                      ],
                    ),
                  ),
                ),

                // 2. Nearby Books Section
                SliverToBoxAdapter(
                  child: _buildSectionHeader("Nearby Books", () {}),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: viewModel.nearbyBooks.length,
                      itemBuilder: (context, index) {
                        return BookListingCard(book: viewModel.nearbyBooks[index]);
                      },
                    ),
                  ),
                ),

                // 3. Popular Section
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: _buildSectionHeader("Popular in Dhaka", () {}),
                ),

                _buildPopularSection(viewModel),

                // 5. Exchange Requests Header
                SliverToBoxAdapter(
                  child: _buildSectionHeader("Book Exchange Requests", () {}),
                ),

                // 6. Horizontal Requests List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.95, // Makes the cards wider than they are tall
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return HomeRequestGridCard(book: viewModel.nearbyBooks[index]);
                      },
                      childCount: viewModel.nearbyBooks.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
                // Add more sections as needed...
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Assalamu Alaikum,", style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "Tamim Hasan", // Replace with auth user name
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24, color: BoipokaTheme.primaryGreen),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 25,
          backgroundColor: BoipokaTheme.deepForest,
          child: Icon(Icons.person, color: Colors.white),
        )
      ],
    );
  }

  Widget _buildSearchBar(HomeViewModel viewModel) {
    return TextField(
      onSubmitted: viewModel.onSearch,
      decoration: InputDecoration(
        hintText: "Search বই / books...",
        prefixIcon: const Icon(Icons.search, color: BoipokaTheme.deepForest),
        suffixIcon: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: BoipokaTheme.primaryGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.tune, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BoipokaTheme.deepForest)),
          TextButton(onPressed: onSeeAll, child: const Text("See All", style: TextStyle(color: BoipokaTheme.primaryGreen))),
        ],
      ),
    );
  }

  Widget _buildPopularSection(HomeViewModel viewModel) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200, // Reduced height for smaller items
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          itemCount: viewModel.popularBooks.length,
          itemBuilder: (context, index) {
            return SmallBookCard(book: viewModel.popularBooks[index]);
          },
        ),
      ),
    );
  }
}
