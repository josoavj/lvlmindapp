import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lvlmindbeta/providers/user_notifier.dart';
import 'package:lvlmindbeta/screens/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mon Profil',
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
      body: Consumer<UserNotifier>(
        builder: (context, userNotifier, _) {
          if (userNotifier.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (userNotifier.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erreur: ${userNotifier.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (!userNotifier.isLoggedIn) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_off,
                    size: 48,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun utilisateur connecté',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            );
          }

          final user = userNotifier.currentUser;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      user?.avatarPath ?? 'assets/images/icons/avatar1.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Theme.of(context).primaryColor.withValues(
                                alpha: 0.2,
                              ),
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nom
                Text(
                  user?.name ?? 'Utilisateur',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                // Matricule
                Text(
                  'Matricule: ${user?.matricule ?? 'N/A'}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 30),
                // Informations détaillées
                _buildProfileSection(
                  context,
                  'Informations personnelles',
                  [
                    _buildProfileField(
                      context,
                      'Nom complet',
                      user?.name ?? 'Non spécifié',
                    ),
                    _buildProfileField(
                      context,
                      'Email',
                      user?.email ?? 'Non spécifié',
                    ),
                    _buildProfileField(
                      context,
                      'Matricule',
                      user?.matricule ?? 'Non spécifié',
                    ),
                    _buildProfileField(
                      context,
                      'Établissement',
                      user?.establishment ?? 'Non spécifié',
                    ),
                    _buildProfileField(
                      context,
                      'Statut',
                      user?.status ?? 'Non spécifié',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Bouton pour modifier le profil
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier le profil'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfilePage(),
                      ),
                    ).then((_) {
                      // Recharger les données après modification
                      Provider.of<UserNotifier>(context, listen: false)
                          .loadCurrentUser();
                    });
                  },
                ),
                const SizedBox(height: 20),
                // Bouton pour se déconnecter
                ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('Se déconnecter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _showLogoutConfirmation(context, userNotifier);
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(
    BuildContext context,
    String title,
    List<Widget> fields,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 15),
          ...fields,
        ],
      ),
    );
  }

  Widget _buildProfileField(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Divider(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(
      BuildContext context, UserNotifier userNotifier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Déconnexion'),
          content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await userNotifier.logout();
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/welcome',
                    (route) => false,
                  );
                }
              },
              child: const Text(
                'Déconnexion',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
