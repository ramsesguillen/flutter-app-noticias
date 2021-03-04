///[]
import 'package:flutter/material.dart';
import 'package:noticias/src/models/category_model.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/theme/tema.dart';
import 'package:noticias/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


///[]


///[]
class Tab2Page extends StatelessWidget {

///[]
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListaCategories(),
            Expanded(
              child: ( newsService.getArticulosCategoriaSeleccionada.length == 0 )
                    ? Center(
                      child: CircularProgressIndicator(),
                    )
                    : ListaNoticias( newsService.getArticulosCategoriaSeleccionada)
            )
          ],
        )
      ),
    );
  }
}

class _ListaCategories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categries;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {

          final cName = categories[index].name;
          return Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(categories[index]),
                  SizedBox( height: 5 ),
                  Text('${ cName[0].toUpperCase() }${ cName.substring(1)}' )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {

    final selectedCategory = Provider.of<NewsService>(context).selectedCategory;

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric( horizontal: 10 ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(
          category.icon,
          color: ( selectedCategory == this.category.name )
                ? miTema.accentColor
                : Colors.black54
        ),
      ),
    );
  }
}
