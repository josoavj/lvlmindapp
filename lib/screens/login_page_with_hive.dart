import 'package:flutter/material.dart';
import '../services/enhanced_auth_service.dart';
import '../services/app_initialization_service.dart';
import '../utils/error_handler.dart';

/// Exemple d'utilisation du service d'authentification avec Hive
class LoginPageWithHive extends StatefulWidget {
  const LoginPageWithHive({super.key});

  @override
  State<LoginPageWithHive> createState() => _LoginPageWithHiveState();
}

class _LoginPageWithHiveState extends State<LoginPageWithHive> {
  final _formKey = GlobalKey<FormState>();
  final _matriculeController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  late EnhancedAuthService _authService;

  @override
  void initState() {
    super.initState();
    // Accéder au service d'authentification initialisé
    _authService = appInit.authService;
  }

  @override
  void dispose() {
    _matriculeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final matricule = _matriculeController.text;
      final password = _passwordController.text;

      // Utiliser le service d'authentification amélioré
      final user = await _authService.login(matricule, password);

      if (mounted) {
        ErrorHandler.showSuccessSnackBar(
          context,
          'Bienvenue ${user?.name}!',
        );

        // Naviguer vers la page d'accueil
        // Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      if (mounted) {
        ErrorHandler.showErrorSnackBar(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Matricule
              TextFormField(
                controller: _matriculeController,
                decoration: InputDecoration(
                  labelText: 'Matricule',
                  hintText: 'Entrez votre matricule',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Le matricule est obligatoire';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  hintText: 'Entrez votre mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Le mot de passe est obligatoire';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Bouton de connexion
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Se connecter'),
                ),
              ),
              const SizedBox(height: 16),

              // Lien "Mot de passe oublié"
              TextButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/forgot-password');
                },
                child: const Text('Mot de passe oublié?'),
              ),

              const SizedBox(height: 16),

              // Stats de la base de données (Debug)
              _buildDebugStats(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDebugStats() {
    final stats = _authService.getDbStats();
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 Stats DB (Debug)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            'Utilisateurs: ${stats['total_users']}',
            style: const TextStyle(fontSize: 11),
          ),
          Text(
            'Connecté: ${stats['is_user_logged_in'] ? 'Oui' : 'Non'}',
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
