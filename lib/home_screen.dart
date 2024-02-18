import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grafana_test_app/business/messages_bloc/messages_bloc.dart';
import 'package:grafana_test_app/business/sender_bloc/sender_bloc.dart';

import 'package:grafana_test_app/data/message_model/message_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Stream'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocBuilder<MessagesBloc, MessagesState>(
            builder: (context, state) {
              return state.maybeWhen(
                loadedMessages: (messageModel) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Received message: ${messageModel.title}"),
                  );
                },
                orElse: () {
                  return Container(
                    child: const Text('No message'),
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = _textEditingController.text;
                    if (message.isNotEmpty) {
                      MessageModel messageModel = MessageModel(title: message);
                      context.read<SenderBloc>().add(SentMessage(messageModel));
                      _textEditingController.clear();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
