import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/core/errors/failures.dart';
import 'package:new_ketaby/feature/news/data/model/news/article.dart';
import 'package:new_ketaby/feature/news/data/repository/news_repo.dart';
import 'package:new_ketaby/feature/news/presentation/cubit/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this.bookRepository) : super(NewsInitialState());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  final NewRepository bookRepository;

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<Article> products = [];

  Future<void> getBooks() async {
    emit(NewsLoadingState());
    Either<Failure, List<Article>> result;
    result = await bookRepository.getNews();
    result.fold(
      (failure) {
        emit(NewsFailureState(failure.error));
      },
      (products) {
        this.products = products;

        print(products[0].title);
        emit(NewsSuccessState(products));
      },
    );
  }

  List<Article> searchedArticlesList = [];

  void getSearchedNewsList({required String articleTitle}) {
    searchedArticlesList =
        products.where((element) {
          return element.title!.toLowerCase().contains(
            articleTitle.toLowerCase(),
          );
        }).toList();
    emit(GetSearchedNewsList());
  }

  void startSearch(BuildContext context) {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    isSearching = true;
    emit(ChangeIsSearchingState());
  }

  void stopSearch() {
    _clearSearch();
    isSearching = false;
    emit(ChangeIsSearchingState());
  }

  void _clearSearch() {
    searchController.clear();
    emit(ChangeIsSearchingState());
  }
}
