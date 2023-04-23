import 'package:animate_do/animate_do.dart';
import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:biblioteca_app/src/services/notifications_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../provider/data_provider.dart';

class Notificaciones extends ConsumerWidget {
  const Notificaciones({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notificacionesData = ref.watch(notificacionDataProvider);

    return notificacionesData.when(
      data: (data) {
        return WillPopScope(
          onWillPop: () async {
            await _editarNotificacion(context);
            return true;
          },
          child: Scaffold(
            appBar: _appBarDesing('Notificaciones', [
              const Color(0xffF2D572),
              const Color(0xffE06AA3),
            ]),
            body: FadeInLeft(
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.notificacion.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          Container(
                            color: data.notificacion[i].visto == 'S'
                                ? Colors.white
                                : Colors.blue[50],
                            child: Row(
                              children: [
                                data.notificacion[i].titulo !=
                                        'Reserva Expirada'
                                    ? const FaIcon(
                                        FontAwesomeIcons.solidCircleXmark,
                                        color: Colors.redAccent,
                                        size: 45)
                                    : const FaIcon(
                                        FontAwesomeIcons.circleExclamation,
                                        color: Colors.orangeAccent,
                                        size: 45),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data.notificacion[i].titulo,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      Text(
                                        data.notificacion[i].mensaje,
                                        maxLines: 3,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        data.notificacion[i].fecha,
                                        style: const TextStyle(
                                            color: Colors.black45),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  )),
            ),
          ),
        );
      },
      error: (err, st) => Text(err.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _editarNotificacion(BuildContext context) async {
    final notifcationServices = NotificationsServices();
    const storage = FlutterSecureStorage();
    final String? uid = await storage.read(key: 'uid');

    await notifcationServices.editarNotificacion(uid!);
  }
}

AppBar _appBarDesing(titleAppbar, colorAppbar) {
  return AppBar(
      elevation: 0,
      title: Text(
        titleAppbar,
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colorAppbar,
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ));
}
