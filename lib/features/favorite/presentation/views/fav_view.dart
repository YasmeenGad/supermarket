import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/widgets/custom_loading_indicator.dart';
import 'package:supermarket/features/cart/presentation/widgets/custom_text_bar.dart';
import 'package:supermarket/features/favorite/presentation/bloc/add_faorite_bloc/add_favorite_bloc.dart';
import 'package:supermarket/features/favorite/presentation/bloc/get_favorite/get_favorite_bloc.dart';
import 'package:supermarket/features/favorite/presentation/widgets/fav_view_body.dart';

class FavView extends StatefulWidget {
  final String productId;

  const FavView({super.key, required this.productId});

  @override
  State<FavView> createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomTextBar(text: 'Favorite'),
      // body: BlocBuilder<AddFavoriteBloc, AddFavoriteState>(
      //   builder: (context, state) {
      //     if (state is AddFavoriteLoading) {
      //       print('loading...1');
      //       return CustomLoadingIndicator();
      //     } else if (state is AddFavoriteSuccess) {
      //       context.read<GetFavoriteBloc>().add(GetFavoriteProducts(widget.productId));

      //       return BlocBuilder<GetFavoriteBloc, GetFavoriteState>(
      //         builder: (context, state) {
      //           if (state is GetFavoriteLoading) {
      //             print('loading...2');
      //             return CustomLoadingIndicator();
      //           } else if (state is GetFavoriteSuccess) {
      //             return FavViewBody(favorite: state.favoriteProducts);
      //           } else if (state is GetFavoriteError) {
      //             return Center(child: Text(state.message));
      //           } else {
      //             return const SizedBox();
      //           }
      //         },
      //       );
      //     } else {
      //       return const SizedBox();
      //     }
      //   },
      // ),
    );
  }
}
