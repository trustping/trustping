import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.connectionState != ConnectionState.active) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'No nonnection. Try later.',
      );
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      itemCount: items.length + 2,
      separatorBuilder: (context, index) => Divider(height: 0.5),
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container(); // zero height: not visible
        }
        return itemBuilder(context, items[index - 1]);
      },
    );
  }
}

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key key,
    this.title = 'Nothing here',
    this.message = 'Add a new item to get started',
  }) : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 32.0, color: Colors.black54),
          ),
          Text(
            message,
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
