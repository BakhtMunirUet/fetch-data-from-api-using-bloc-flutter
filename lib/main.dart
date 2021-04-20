import 'package:bloc_api_post/bloc/post_bloc.dart';
import 'package:bloc_api_post/model/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Bloc Post Api Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: FlatButton(
            child: Text("Load Bloc"),
            color: Colors.red,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApiTest()),
              );
            },
          ),
        )
        // body: Column(
        //   children: [],
        // ),
        );
  }
}

class ApiTest extends StatefulWidget {
  ApiTest({Key key}) : super(key: key);

  @override
  _ApiTestState createState() => _ApiTestState();
}

class _ApiTestState extends State<ApiTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Post Api Test"),
      ),
      body: BlocProvider(
        create: (context) => PostBloc(),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            context.bloc<PostBloc>().add(PostFetched());
            if (state is PostInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PostFailure) {
              return Center(
                child: Text('failed to fetch posts'),
              );
            }
            if (state is PostSuccess) {
              if (state.posts.isEmpty) {
                return Center(
                  child: Text('no posts'),
                );
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return PostWidget(post: state.posts[index]);
                },
                itemCount: state.posts.length,
              );
            }
            return Container();
          },
        ),
      ),
      // body: Column(
      //   children: [],
      // ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
