import 'package:boi_poka/home/components/book_listing_card.dart';
import 'package:boi_poka/home/components/small_book_card.dart';
import 'package:boi_poka/home/viewmodel/home_view_model.dart';
import 'package:boi_poka/home/widgets/request_card.dart';
import 'package:boi_poka/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> dhakaAreas = [
    "Uttara",
    "Gulshan",
    "Banani",
    "Mirpur",
    "Dhanmondi",
    "Mohammadpur",
    "Bashundhara R/A",
    "Badda",
    "Khilgaon",
    "Mohakhali",
    "Farmgate",
    "Old Dhaka",
    "Puran Dhaka",
  ];

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => context.read<HomeViewModel>().initLocationCheck());
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.status == HomeStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: BoipokaTheme.primaryGreen,
                ),
              );
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildLocationHeader(context),
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor: BoipokaTheme.deepForest,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                          ],
                        ),

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
                        return BookListingCard(
                          book: viewModel.nearbyBooks[index],
                        );
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio:
                              0.95, // Makes the cards wider than they are tall
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return HomeRequestGridCard(
                        book: viewModel.nearbyBooks[index],
                      );
                    }, childCount: viewModel.nearbyBooks.length),
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

  Widget _buildLocationHeader(BuildContext context) {
    return InkWell(
      onTap: () => _showLocationPicker(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFF00D632), size: 18),
            const SizedBox(width: 8),
            Text(
              context.read<HomeViewModel>().currentLocationName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showLocationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Location",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Option 1: Current Location
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE8F5E9),
                  child: Icon(Icons.my_location, color: Color(0xFF00D632)),
                ),
                title: const Text("Use Current Location"),
                subtitle: const Text("Find books near you automatically"),
                onTap: () async {
                  try {
                    Position? position = await context
                        .read<HomeViewModel>()
                        .determineUserPosition();
                    print(
                      "Success: ${position.latitude}, ${position.longitude}",
                    );
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Your location has been updated"),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
              ),

              const Divider(height: 32),

              // Option 2: Predefined List
              const Text(
                "Or choose from below",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 200, // Fixed height for the area list
                child: ListView.builder(
                  itemCount: dhakaAreas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(dhakaAreas[index]),
                      trailing: const Icon(Icons.chevron_right, size: 18),
                      onTap: () {
                        // Update UI/ViewModel with selection
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Good Morning,", style: Theme.of(context).textTheme.bodyMedium),
        Text(
          "Tamim Hasan", // Replace with auth user name
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 24,
            color: BoipokaTheme.primaryGreen,
          ),
        ),
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: BoipokaTheme.deepForest,
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: const Text(
              "See All",
              style: TextStyle(color: BoipokaTheme.primaryGreen),
            ),
          ),
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
