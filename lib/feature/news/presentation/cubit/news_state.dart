import 'package:new_ketaby/feature/news/data/model/news/article.dart';

abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsSuccessState extends NewsState {
  final List<Article> products;

  NewsSuccessState(this.products);
}

class NewsFailureState extends NewsState {
  final String error;

  NewsFailureState(this.error);
}

class GetSearchedNewsList extends NewsState {}

class ChangeIsSearchingState extends NewsState {}
