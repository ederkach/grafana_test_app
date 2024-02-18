import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grafana_test_app/business/messages_bloc/messages_bloc.dart';
import 'package:grafana_test_app/business/sender_bloc/sender_bloc.dart';
import 'package:grafana_test_app/data/data_source/messages_repository/messages_repository.dart';
import 'package:grafana_test_app/data/network/api/messages_api.dart';
import 'package:grafana_test_app/data/network/dio_client.dart';
import 'package:grafana_test_app/home_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    MessagesApi messagesApi = MessagesApi(dioClient: DioClient(Dio()));
    return MultiProvider(
      providers: [
        BlocProvider<MessagesBloc>(
            lazy: false,
            create: (_) => MessagesBloc(
                messagesService: MessagesRepository(messagesApi: messagesApi))
              ..add(const GetStreamMessages())),
        BlocProvider<SenderBloc>(
            lazy: false,
            create: (_) => SenderBloc(
                messagesService: MessagesRepository(messagesApi: messagesApi)))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grafana Client',
        home: HomeWidget(),
      ),
    );
  }
}
