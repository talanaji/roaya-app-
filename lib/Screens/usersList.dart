/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import 'dart:convert';

import 'package:Roaya/API/userAPI.dart';
import 'package:Roaya/classes/user.dart';
import 'package:Roaya/login_page.dart';
import 'package:flutter/material.dart';


class UsersListPage extends StatefulWidget {
  UsersListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  UserList userList = UserList();

  void getUserData() async {
    var userJson = await UserAPI().getUsers();
    print(userJson);

    var userMap = json.decode(userJson);
    setState(() {
      userList = UserList.fromJson(userMap);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hh'),
        ),
      body: ListView.builder(
          itemCount: (userList == null ||
              userList.users == null ||
              userList.users.length == 0)
              ? 0
              : userList.users.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                      //catId: breedList.breeds[index].id,
                      //catBreed: breedList.breeds[index].name);
                }));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(userList.users[index].uUsername.toString()),
                    subtitle: Text(userList.users[index].uFname.toString()),
                    ),
                  ),
                ),
              );
          }),
      );
  }
}
