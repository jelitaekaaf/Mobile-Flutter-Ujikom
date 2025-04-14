import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventera/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.profile.value;

        return data.id == null
            ? const Center(child: Text('Data tidak tersedia'))
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          _getInitials(data.name),
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        data.name ?? '-',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data.email ?? '-',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.fetchProfile(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return "?";
    List<String> parts = name.trim().split(" ");
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}