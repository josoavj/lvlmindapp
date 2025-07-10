// lib/screens/edit_profile_page.dart

import 'package:flutter/material.dart';
import 'package:lvlmindbeta/Models/user.dart'; // Importez votre modèle User
import 'package:lvlmindbeta/services/authentificationService.dart'; // Importez votre AuthService

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final User? user = await _authService.getLoggedInUser();
      if (user != null) {
        _nameController.text = user.name;
        _emailController.text = user.email;
      } else {
        // Gérer le cas où l'utilisateur n'est pas trouvé
        _showSnackBar("Impossible de charger le profil de l'utilisateur.");
      }
    } catch (e) {
      _showSnackBar("Erreur lors du chargement du profil: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _authService.updateUserProfile(
          name: _nameController.text,
          email: _emailController.text,
        );
        _showSnackBar("Profil mis à jour avec succès !");
        // Optionnel: Revenir à la page précédente après la sauvegarde
        Navigator.pop(context);
      } catch (e) {
        _showSnackBar("Erreur lors de la mise à jour du profil: $e");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message) {
    if (mounted) { // S'assurer que le widget est toujours monté
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modifier le profil",
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre nom';
                        }
                        return null;
                      },
                      style: const TextStyle(fontFamily: 'Josefin'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                      style: const TextStyle(fontFamily: 'Josefin'),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Sauvegarder les modifications',
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}