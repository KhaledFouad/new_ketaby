import 'package:new_ketaby/feature/news/data/model/news/article.dart';

abstract class NewsState {}

class BooksInitialState extends NewsState {}

class BooksLoadingState extends NewsState {}

class BooksSuccessState extends NewsState {
  final List<Article> products;

  BooksSuccessState(this.products);
}

class BooksFailureState extends NewsState {
  final String error;

  BooksFailureState(this.error);
}

class GetSearchedBooksList extends NewsState {}

class ChangeIsSearchingState extends NewsState {}
