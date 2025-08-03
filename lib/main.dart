import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xusbjjxqugoxukgzwonb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh1c2JqanhxdWdveHVrZ3p3b25iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQxNDMyMTYsImV4cCI6MjA2OTcxOTIxNn0.iWqtNcNPyO-udPKYOGArI8tFgwxi7AglgIcUsjbTzXg',
  );

  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userId;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _userId = data.session?.user.id;
      });
    });
  }

  Future<void> _googleSignIn() async {
    const webClientId =
        '1017321186550-1ce81p7rh1u9nnef8juluoek2ii8pb72.apps.googleusercontent.com';

    await googleSignIn.initialize(serverClientId: webClientId);
    final googleUser = await googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;

    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      // accessToken: accessToken,
    );
  }

  Future<void> _googleSignOut() async {
    await googleSignIn.signOut();
    await supabase.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userId ?? 'Not signed in'),
            ElevatedButton(
              onPressed: _userId == null ? _googleSignIn : _googleSignOut,
              child: Text(_userId == null ? 'Sign in with Google' : 'Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
