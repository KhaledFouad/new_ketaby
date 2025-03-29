import 'package:dartz/dartz.dart';
import 'package:new_ketaby/core/errors/failures.dart';
import 'package:new_ketaby/feature/news/data/model/news/article.dart';

abstract class NewRepository {
  Future<Either<Failure, List<Article>>> getNews();
}
