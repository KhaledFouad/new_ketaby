import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ketaby/core/errors/failures.dart';
import 'package:new_ketaby/feature/books/data/model/news/article.dart';
import 'package:new_ketaby/feature/books/data/repository/book_repo.dart';
import 'package:new_ketaby/feature/books/presentation/cubit/books_state.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit(this.bookRepository) : super(BooksInitialState());

  static BooksCubit get(BuildContext context) => BlocProvider.of(context);

  final BookRepository bookRepository;

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<Article> products = [];

  Future<void> getBooks() async {
    emit(BooksLoadingState());
    Either<Failure, List<Article>> result;
    result = await bookRepository.getNews();
    result.fold(
      (failure) {
        emit(BooksFailureState(failure.error));
      },
      (products) {
        this.products = products;

        print(products[0].title);
        emit(BooksSuccessState(products));
      },
    );
  }

  List<Article> searchedBooksList = [];

  void getSearchedDoctorsList({required String bookName}) {
    searchedBooksList =
        products.where((element) {
          return element.title!.toLowerCase().contains(bookName.toLowerCase());
        }).toList();
    emit(GetSearchedBooksList());
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
