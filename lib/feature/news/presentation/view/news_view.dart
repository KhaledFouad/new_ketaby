import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/config/icons/icons_broken.dart';
import 'package:new_ketaby/core/utils/app_colors.dart';
import 'package:new_ketaby/feature/news/presentation/cubit/news_cubit.dart';
import 'package:new_ketaby/feature/news/presentation/cubit/news_state.dart';
import 'package:new_ketaby/feature/news/presentation/view/widgets/news_view_body.dart';
import 'package:new_ketaby/feature/news/presentation/view/widgets/search_text_field.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    NewsCubit.get(context).getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title:
                NewsCubit.get(context).isSearching
                    ? SearchTextField(
                      controller: NewsCubit.get(context).searchController,
                      onChange: (value) {
                        if (!value.startsWith(' ')) {
                          NewsCubit.get(
                            context,
                          ).getSearchedNewsList(articleTitle: value);
                        }
                      },
                    )
                    : const Text('News'),
            actions: [
              NewsCubit.get(context).isSearching
                  ? IconButton(
                    onPressed: () {
                      NewsCubit.get(context).stopSearch();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear, color: AppColors.white),
                  )
                  : IconButton(
                    onPressed: () {
                      NewsCubit.get(context).startSearch(context);
                    },
                    icon: const Icon(IconBroken.Search, color: AppColors.white),
                  ),
            ],
          ),
          body: const BooksViewBody(),
        );
      },
    );
  }
}
