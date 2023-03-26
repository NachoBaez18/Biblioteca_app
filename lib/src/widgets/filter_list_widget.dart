import 'package:biblioteca_app/src/provider/data_provider.dart';
import 'package:biblioteca_app/src/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider_status;

class FilterListWidget extends ConsumerWidget {
  const FilterListWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final filter =
        provider_status.Provider.of<FilterListProvider>(context, listen: false);
    final carreras = ref.watch(carreraDataProvider);

    return carreras.when(
      data: (carreras) {
        return Container(
          height: 30,
          margin: const EdgeInsets.only(left: 10),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: carreras!.carreras.length,
              itemBuilder: (_, int i) {
                return GestureDetector(
                  onTap: () {
                    filter.filter = i;
                    filter.rotate = true;
                    filter.opacity = 0;
                    filter.hero = false;
                    Future.delayed(const Duration(milliseconds: 500), () {
                      filter.opacity = 1;
                      filter.rotate = false;
                    });

                    ref
                        .read(carreraFilterProvider.notifier)
                        .update((state) => carreras.carreras[i]);
                  },
                  child: _ItemFilter(carreras.carreras[i].nombre, i),
                );
              }),
        );
      },
      error: (err, s) => Text(err.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ItemFilter extends StatelessWidget {
  final String item;
  final int i;

  const _ItemFilter(
    this.item,
    this.i,
  );

  @override
  Widget build(BuildContext context) {
    final filteSelected =
        provider_status.Provider.of<FilterListProvider>(context);
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 30,
        width: item.length * 10.0,
        decoration: BoxDecoration(
          color: filteSelected.filter == i ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
            child: Text(
          item,
          style: TextStyle(
              color: filteSelected.filter == i ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
