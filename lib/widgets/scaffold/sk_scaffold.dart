import 'package:flutter/material.dart';
import 'package:skyradio_mobile/bloc/radios/radios_bloc.dart';
import 'package:skyradio_mobile/core/bloc.dart';

class SkScaffold extends StatefulWidget {
  const SkScaffold({
    super.key,
    required this.title,
    required this.bloc,
  });

  final String title;
  final SkBloc bloc;

  @override
  State<SkScaffold> createState() => _SkScaffoldState();
}

class _SkScaffoldState extends State<SkScaffold> {
  @override
  void initState() {
    super.initState();

    widget.bloc.onEvent(RadiosBlocGetAll());
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: widget.bloc.stream,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (snapshot.hasData) {
            final data = snapshot.data;

            if (data is RadiosBlocLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (data is RadiosBlocLoaded) {
              return ListView.builder(
                itemCount: data.radios.length,
                itemBuilder: (_, index) {
                  final client = data.radios[index];

                  return ListTile(
                    title: Text(client.name),
                  );
                },
              );
            }
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
