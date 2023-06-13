import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post.dart';
import 'package:instagram_clone/screens/feed.dart';
import 'package:instagram_clone/screens/profile.dart';
import 'package:instagram_clone/screens/search.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPost(),
  const Text('notifications'),
  const ProfileScreen()
];
