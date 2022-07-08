import 'user_model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user, 
    required this.index,
  }) : super(key: key);

  final User user;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.primaries[index%Colors.primaries.length][200],
      child: ListTile(
        leading: Image.network(user.avatar),
        title: Text(user.fullName),
        subtitle: Text(user.email),
      ),
    );
  }
}