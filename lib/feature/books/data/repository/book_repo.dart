import 'package:dartz/dartz.dart';
import 'package:new_ketaby/core/errors/failures.dart';
import 'package:new_ketaby/feature/books/data/model/news/article.dart';

abstract class BookRepository {
  Future<Either<Failure, List<Article>>> getNews();
}
