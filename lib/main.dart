import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'image_bloc.dart';
import 'image_event.dart';
import 'image_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  String prompt = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Image From Your Imagination'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocListener<ImageBloc, ImageState>(
                  listener: (context, state) {
                    if (state is ImageError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${state.message}')),
                      );
                    }
                  },
                  child: BlocBuilder<ImageBloc, ImageState>(
                    builder: (context, state) {
                      if (state is ImageInitial) {
                        return Text('Enter a prompt to fetch an image');
                      } else if (state is ImageLoaded) {
                        return Image.network(
                          state.imageUrlModel.url,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, size: 50, color: Colors.red);
                          },
                        );
                      } else if (state is ImageError) {
                        return Text('Error: ${state.message}');
                      }
                      return Container();
                    },
                  ),
                ),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: '',
                  ),
                  onChanged: (text) {
                    setState(() {
                      prompt = text;
                    });
                  },
                ),
                SizedBox(height: 20),
                BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, state) {
                    if (state is ImageLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          final promptText = _controller.text;
                          context.read<ImageBloc>().add(FetchImage(promptText));
                          _controller.clear(); // Clear the text field
                        },
                        child: Text('Enter'),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Text Entered: $prompt',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
