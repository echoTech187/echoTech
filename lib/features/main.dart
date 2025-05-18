import 'dart:async';

import 'package:echo_tech/features/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/util/legacy_to_async_migration_util.dart';

import '../utils/components/state.builder.dart';
import 'auth/auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  get controller => null;
  final Future<SharedPreferencesWithCache> _prefs =
      SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      // This cache will only accept the key 'counter'.
      allowList: <String>{'token'},
    ),
  );
  final Completer<void> _preferencesReady = Completer<void>();
  Future<String>? _token;

  Future<void> _migratePreferences() async {
    // #docregion migrate
    const SharedPreferencesOptions sharedPreferencesOptions =
        SharedPreferencesOptions();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await migrateLegacySharedPreferencesToSharedPreferencesAsyncIfNecessary(
      legacySharedPreferencesInstance: prefs,
      sharedPreferencesAsyncOptions: sharedPreferencesOptions,
      migrationCompletedKey: 'migrationCompleted',
    );
    // #enddocregion migrate
  }

  @override
  void initState() {
    super.initState();
    _migratePreferences().then((_) {
      _token = _prefs.then((SharedPreferencesWithCache prefs) {
        return prefs.getString("token") ?? "";
      });
      _preferencesReady.complete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WaitForInitialization(
      initialized: _preferencesReady.future,
      builder: (BuildContext context) => FutureBuilder<String>(
        future: _token,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return snapshot.hasData
                    ? _token.toString().isNotEmpty
                        ? const HomePage()
                        : const AuthPage()
                    : const AuthPage();
              }
          }
        },
      ),
    );
  }
}
