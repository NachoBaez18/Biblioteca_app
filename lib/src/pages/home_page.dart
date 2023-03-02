import 'package:animate_do/animate_do.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final Function() onpress;

  ItemBoton(this.icon, this.texto, this.color1, this.color2,{required this.onpress});
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLarge;
    if (MediaQuery.of(context).size.height > 550) {
      isLarge = true;
    } else {
      isLarge = false;
    }

    final items = <ItemBoton>[
      ItemBoton(
        FontAwesomeIcons.magnifyingGlass,
        'Buscar Libro',
        const Color(0xff6989F5),
        const Color(0xff906EF5),
        onpress: (){
            Navigator.pushNamed(context, 'books_list');
        }
        
      ),
      ItemBoton(
        FontAwesomeIcons.clockRotateLeft,
        'Historial de libros ',
        const Color(0xff66A9F2),
        const Color(0xff536CF6),
        onpress:() {
          
        },
      ),
      ItemBoton(
        FontAwesomeIcons.bell,
        'Notificaciones',
        const Color(0xffF2D572),
        const Color(0xffE06AA3),
        onpress: () {
          
        },
      ),
      ItemBoton(
        FontAwesomeIcons.user,
        'Perfil',
        const Color(0xff317183),
        const Color(0xff46997D),
        onpress: () {
          Navigator.pushNamed(context, 'perfil');
        },
      ),
    ];

    List<Widget> itemMap = items
        .map(
          (item) => FadeInLeft(
            child: BotonGordo(
              texto: item.texto,
              onpress:item.onpress,
              icon: item.icon,
              color1: item.color1,
              color2: item.color2,
            ),
          ),
        )
        .toList();

    return Scaffold(
        body: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: (isLarge) ? 220 : 10),
          child: SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                if (isLarge)const SizedBox(height: 80),
                ...itemMap,
              ],
            ),
          ),
        ),
        if (isLarge)const _Encabezado()
      ],
    ));
  }
}

class _Encabezado extends StatelessWidget {
  const _Encabezado({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String user = 'Cristino Baez ';
    return Stack(
      children: [
       const IconHeader(
          icon: FontAwesomeIcons.bookOpenReader,
          titulo: user,
          subTitulo: 'Bienvenido!',
          color2: Color(0xff66A9F2),
          color1: Color(0xff536CF6),
        ),
        Positioned(
            right: 0,
            top: 45,
            child: RawMaterialButton(
              onPressed: () {},
              shape:const CircleBorder(),
              padding:const EdgeInsets.all(15.0),
              child:const FaIcon(
                FontAwesomeIcons.arrowRightFromBracket,
                color: Colors.white,
                size: 30,
              ),
            ))
      ],
    );
  }
}
