import 'package:bloc/bloc.dart';
import 'package:flutterblocapi/bloc/article_event.dart';
import 'package:flutterblocapi/bloc/article_state.dart';
import 'package:flutterblocapi/data/model/api_result_model.dart';
import 'package:flutterblocapi/data/repository/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

  ArticleBloc(this.repository);

  @override
  ArticleState get initialState => ArticleInitialState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticleEvent) {
      yield ArticleLoadingState();
      try {
        List<Articles> articles = await repository.getArticles();
        yield ArticleLoadedState(articlesList: articles);
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    }
  }
}
