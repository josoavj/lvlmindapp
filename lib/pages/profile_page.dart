import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';
import '../providers/user_notifier.dart';
import '../screens/settings.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserProfile? _currentUserProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    // Charger depuis le UserNotifier
    if (mounted) {
      final userNotifier = Provider.of<UserNotifier>(context, listen: false);
      await userNotifier.loadCurrentUser();
      if (mounted) {
        setState(() {
          _currentUserProfile = userNotifier.currentUser;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUserProfile == null) {
      return Scaffold(
        appBar: _buildAppBar(Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.onPrimary),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final String userName = _currentUserProfile!.name;
    final String userStatus = _currentUserProfile!.status;
    final String userMatricule = _currentUserProfile!.matricule;
    final String userEstablishment = _currentUserProfile!.establishment;
    final String userAvatarPath = _currentUserProfile!.avatarPath;

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final Color sectionTitleColor =
        Theme.of(context).textTheme.titleLarge?.color ?? Colors.black;

    return Scaffold(
      appBar: _buildAppBar(primaryColor, onPrimaryColor),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        children: [
          Card(
            color: primaryColor,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: onPrimaryColor,
                    child: ClipOval(
                      child: Image.asset(
                        userAvatarPath,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 60,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: onPrimaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          userStatus,
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: onPrimaryColor.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Matricule: $userMatricule',
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: onPrimaryColor.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Établissement: $userEstablishment',
                          style: TextStyle(
                            fontFamily: 'Josefin',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: onPrimaryColor.withValues(alpha: 0.7),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          _buildSectionTitle("Mes Cours Préférés", sectionTitleColor),
          const SizedBox(height: 15),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildCourseCard(
                  'assets/images/course_placeholder_${index + 1}.png',
                  'Cours de ${['Flutter', 'Python', 'Web Dev', 'IA'][index]}',
                  '${(index + 1) * 10}h de suivi',
                  textColor,
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          _buildSectionTitle("Activité Hebdomadaire", sectionTitleColor),
          const SizedBox(height: 15),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                // CORRECTION ICI: Changement de BoxBoxShadow à BoxShadow
                BoxShadow(
                  color: Theme.of(context).shadowColor.withValues(alpha: 0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bar_chart,
                    size: 80, color: Theme.of(context).iconTheme.color),
                const SizedBox(height: 10),
                Text(
                  "Graphique d'activité ici",
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 18,
                    color: textColor.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "3h 45min étudiées cette semaine",
                  style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 15,
                    color: textColor.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildOptionTile(
              Icons.settings, "Paramètres", primaryColor, textColor, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          }),
          _buildOptionTile(
              Icons.help_outline, "Aide et Support", primaryColor, textColor,
              () {/* Naviguer vers l'aide */}),
          _buildOptionTile(Icons.logout, "Déconnexion", primaryColor, textColor,
              () async {
            final userNotifier =
                Provider.of<UserNotifier>(context, listen: false);
            final navigator = Navigator.of(context);
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: const Text(
                    "Déconnexion",
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  content: const Text(
                    "Êtes-vous sûr de vouloir vous déconnecter ?",
                    style: TextStyle(
                      fontFamily: 'Josefin',
                      fontSize: 16,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: const Text("Annuler"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      child: const Text(
                        "Déconnexion",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );

            if (confirmed == true && mounted) {
              await userNotifier.logout();
              if (mounted) {
                navigator.pushNamedAndRemoveUntil(
                  '/welcome',
                  (route) => false,
                );
              }
            }
          }),
        ],
      ),
    );
  }

  // --- Widgets de construction pour la réutilisabilité ---

  AppBar _buildAppBar(Color primaryColor, Color onPrimaryColor) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Mon Profil",
        style: TextStyle(
          fontFamily: 'Josefin',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: onPrimaryColor,
        ),
      ),
      automaticallyImplyLeading:
          false, // Assure qu'aucun bouton retour par défaut n'apparaît
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Josefin',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }

  Widget _buildCourseCard(
      String imagePath, String title, String duration, Color textColor) {
    return Container(
      width: 140,
      height: 200,
      margin: const EdgeInsets.only(right: 15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme.of(context).cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.school,
                    size: 60,
                    color: Theme.of(context)
                        .iconTheme
                        .color
                        ?.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text(
                duration,
                style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 12,
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, Color iconColor,
      Color textColor, VoidCallback onTap) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            size: 18,
            color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.7)),
        onTap: onTap,
      ),
    );
  }
}
