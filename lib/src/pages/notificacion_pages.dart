import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notificaciones extends StatelessWidget {
  const Notificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    final notificaciones = <Notificacion>[
      Notificacion(
          'Entraga de Libro:',
          'Su fecha de entrega de libro a llegado favor acercar a la biblioteca con el libro "Nombre del libro"',
          '26 de feb. a las 20:45',
          1,
          false),
      Notificacion(
          'Reserva de Libro:',
          'Su reserva del libro "Nombre del libro" ha sido cancelada por incumplimento de fecha de retiro',
          '26 de feb. a las 20:45',
          2,
          false),
      Notificacion(
          'Entraga de Libro:',
          'Su fecha de entrega de libro a llegado favor acercar a la biblioteca con el libro "Nombre del libro"',
          '26 de feb. a las 20:45',
          1,
          false),
      Notificacion(
          'Reserva de Libro:',
          'Su reserva del libro "Nombre del libro" ha sido cancelada por incumplimento de fecha de retiro',
          '26 de feb. a las 20:45',
          2,
          true),
      Notificacion(
          'Entraga de Libro:',
          'Su fecha de entrega de libro a llegado favor acercar a la biblioteca con el libro "Nombre del libro"',
          '26 de feb. a las 20:45',
          1,
          true),
      Notificacion(
          'Reserva de Libro:',
          'Su reserva del libro "Nombre del libro" ha sido cancelada por incumplimento de fecha de retiro',
          '26 de feb. a las 20:45',
          2,
          true),
      Notificacion(
          'Entraga de Libro:',
          'Su fecha de entrega de libro a llegado favor acercar a la biblioteca con el libro "Nombre del libro"',
          '26 de feb. a las 20:45',
          1,
          true),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: notificaciones.length,
            separatorBuilder: (BuildContext context, int i) => const Divider(),
            itemBuilder: (BuildContext context, int i) {
              return Container(
                color:notificaciones[i].visto ? Colors.white : Colors.blue[50] ,
                child: Row(
                  children: [
                    notificaciones[i].tipo == 1
                        ? const FaIcon(FontAwesomeIcons.solidCircleXmark,
                            color: Colors.redAccent, size: 45)
                        : const FaIcon(FontAwesomeIcons.circleExclamation,
                            color: Colors.orangeAccent, size: 45),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notificaciones[i].titulo,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text(
                            notificaciones[i].mensaje,
                            maxLines: 3,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            notificaciones[i].fecha,
                            style: const TextStyle(color: Colors.black45),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class Notificacion {
  final String titulo;
  final String mensaje;
  final String fecha;
  final int tipo;
  final bool visto;

  Notificacion(this.titulo, this.mensaje, this.fecha, this.tipo, this.visto);
}
