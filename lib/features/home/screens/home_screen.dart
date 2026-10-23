import 'package:ecommerce_app_huma_volve/core/dummy_data.dart';
import 'package:ecommerce_app_huma_volve/core/enums/request_status_enum.dart';
import 'package:ecommerce_app_huma_volve/core/theme.dart';
import 'package:ecommerce_app_huma_volve/features/home/cubit/home_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_service.dart';
import 'package:ecommerce_app_huma_volve/features/home/widgets/category_chip.dart';
import 'package:ecommerce_app_huma_volve/features/home/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeService()),
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: AppTheme.primary,
                            ),
                          ),
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                              dummyUser.profilePictureUrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Explore',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(fontSize: 36),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Best trendy collection!',
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search clothes...',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            suffixIcon: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          switch (state.categoryStatus) {
                            case RequestStatusEnum.initial:
                            case RequestStatusEnum.loading:
                              return SizedBox(
                                height: 44,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 150,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );

                            // const SizedBox(
                            //   height: 44,
                            //   child: Center(
                            //     child: CircularProgressIndicator(),
                            //   ),
                            // );
                            case RequestStatusEnum.loaded:
                              return SizedBox(
                                height: 44,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.categoryList.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 12),
                                  itemBuilder: (context, index) {
                                    return CategoryChip(
                                      label:
                                          state.categoryList[index].name ?? "",
                                      isSelected:
                                          state.selectedCategory == index,
                                      onTap: () {
                                        context
                                            .read<HomeCubit>()
                                            .updateSelectedCategory(index);
                                      },
                                    );
                                  },
                                ),
                              );

                            case RequestStatusEnum.error:
                              return SizedBox(
                                height: 44,
                                child: Center(
                                  child: TextButton.icon(
                                    onPressed: () => context
                                        .read<HomeCubit>()
                                        .getCategories(),
                                    icon: const Icon(Icons.refresh),
                                    label: const Text(
                                      'Could not load categories. Tap to retry.',
                                    ),
                                  ),
                                ),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  switch (state.productStatus) {
                    case RequestStatusEnum.initial:
                    case RequestStatusEnum.loading:
                      return const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 44,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    case RequestStatusEnum.loaded:
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return ProductCard(
                              product: state.productList[index],
                            );
                          }, childCount: state.productList.length),
                        ),
                      );
                    case RequestStatusEnum.error:
                      return Expanded(
                        child: SliverToBoxAdapter(
                          child: SizedBox(
                            child: Center(
                              child: TextButton.icon(
                                onPressed: () =>
                                    context.read<HomeCubit>().getCategories(),
                                icon: const Icon(Icons.refresh),
                                label: const Text(
                                  'Could not load categories. Tap to retry.',
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                  }
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
