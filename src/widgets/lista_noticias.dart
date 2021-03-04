///[]
import 'package:flutter/material.dart';



import 'package:noticias/src/models/news_models.dart';
import 'package:noticias/src/theme/tema.dart';


///[]


///[]
class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias( this.noticias );

///[]
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (context, index) {
        return _Noticia( noticia: noticias[index], index: index);
      },
    );
  }

}




///[]
class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({
    @required this.noticia,
    this.index
  });

///[]
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TargetaTopBar(noticia, index),
        _TargetTitulo( noticia ),
        _TargetImagen( noticia ),
        _TargetBody( noticia ),

        _TargetBoton(),

        SizedBox( height: 10,),
        Divider()
      ],
    );
  }
}


///[]
class _TargetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TargetaTopBar( this.noticia, this.index );

///[]
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10),
      margin: EdgeInsets.only( bottom: 10),
      child: Row(
        children: [
          Text('${ index + 1}. ', style: TextStyle(color: miTema.accentColor)),
          Text('${noticia.source.name}')
        ],
      ),
    );
  }
}


///[]
class _TargetTitulo extends StatelessWidget {

  final Article noticia;

  _TargetTitulo( this.noticia );

///[]
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 15),
      child: Text(noticia.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}


///[]
class _TargetBoton extends StatelessWidget {


///[]
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: miTema.accentColor,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),

          SizedBox( width: 10,),

          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

///[]
class _TargetBody extends StatelessWidget {

  final Article noticia;

  _TargetBody( this.noticia );

///[]
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20),
      child: Text((noticia.description != null) ? noticia.description : ''),
    );
  }
}


///[]
class _TargetImagen  extends StatelessWidget {

  final Article noticia;

  _TargetImagen( this.noticia );

///[]
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only( topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: ( noticia.urlToImage != null ) ? FadeInImage(
            placeholder: AssetImage('assets/giphy.gif'),
            image: NetworkImage(noticia.urlToImage)
          )
          : Image(image: AssetImage('assets/no-image.png'))
        ),
      ),
    );
  }
}



