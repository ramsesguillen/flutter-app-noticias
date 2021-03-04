import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



import 'package:noticias/src/models/news_models.dart';
import 'package:noticias/src/models/category_model.dart';



const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY   = 'd547f524171f4eb5ad64b356e5faba13';


class NewsService with ChangeNotifier {


  List<Article> headLines = [];

  String _selectedCategory = 'business';


// business entertainment general health science sports technology
  List<Category> categries = [
    Category( FontAwesomeIcons.building, 'business' ),
    Category( FontAwesomeIcons.tv, 'entertainment' ),
    Category( FontAwesomeIcons.addressCard, 'general' ),
    Category( FontAwesomeIcons.headSideVirus, 'health' ),
    Category( FontAwesomeIcons.vials, 'science' ),
    Category( FontAwesomeIcons.volleyballBall, 'sports' ),
    Category( FontAwesomeIcons.memory, 'technology' ),
  ];


  Map<String, List<Article>> categoryArticle = {};


  get selectedCategory => this._selectedCategory;
  set selectedCategory( String valor ) {
    this._selectedCategory = valor;
    getArticleByCategory( valor );

    notifyListeners();
  }


  NewsService() {
    this.getTopHeadlines();

    categries.forEach((item) {
      this.categoryArticle[item.name] = new List();
    });
  }


  List<Article> get getArticulosCategoriaSeleccionada => this.categoryArticle[this.selectedCategory];


  getTopHeadlines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );

    this.headLines.addAll( newsResponse.articles );
    notifyListeners();
  }


  getArticleByCategory( String category ) async {
    if ( this.categoryArticle[category].length > 0 ){
      return this.categoryArticle[category];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx&category=$category';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );
    this.categoryArticle[category].addAll( newsResponse.articles );

    notifyListeners();
  }







}

