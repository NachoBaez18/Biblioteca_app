import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'books_list');
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.barsStaggered,
                      size: 25,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  const _NombreYalgoMasBook(),
                  const _ImageBook(),
                  Positioned(
                    left: 60,
                    top: 300,
                    right: 15,
                    child: SizedBox(
                      height: 450,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.share),
                                color: Colors.black26,
                              ),
                              const Text(
                                'Compartir',
                                style: TextStyle(color: Colors.black26),
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.black26,
                                ),
                              ),
                              const Text(
                                'Me gusta',
                                style: TextStyle(color: Colors.black26),
                              ),
                            ],
                          ),
                          Container(
                            height: 2,
                            width: 340,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Descripcion Libro',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Elit non do esse ipsum aute cupidatat nostrud officia ea consectetur aute ipsum officia. Ullamco magna eiusmod eu magna eu laborum ipsum nostrud deserunt id nulla. Elit reprehenderit dolor enim voluptate elit mollit dolor occaecat ipsum quis nulla consequat minim veniam. Incididunt Lorem occaecat incididunt aliqua voluptate irure id exercitation ex. Aute aliquip non elit ut nostrud irure anim sunt minim occaecat culpa eu eu deserunt. Voluptate est nulla irure minim incididunt ut. Adipisicing dolore irure ex ex enim reprehenderit reprehenderit incididunt.',
                            style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      width: 200,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        'Reservar ahora',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageBook extends StatelessWidget {
  const _ImageBook({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      child: Hero(
        tag: 'dash0',
        child: Container(
          height: 250,
          width: 170,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/image1.jpg'),
              )),
        ),
      ),
    );
  }
}

class _NombreYalgoMasBook extends StatelessWidget {
  const _NombreYalgoMasBook({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 42, top: 70),
      height: MediaQuery.of(context).size.height * 0.82,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.grey[100],
      child: Container(
        margin: const EdgeInsets.only(left: 160, top: 70, right: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Storia  asdada asasddd',
              maxLines: 2,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'By Nombre Autor',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20),
            StarIcons(3),
          ],
        ),
      ),
    );
  }
}
