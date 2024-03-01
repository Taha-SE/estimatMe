import 'package:app/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/snackbar_widget.dart';
import '../domain/estimation_model.dart';
import 'estimation_notifier_provider.dart';

class EstimationPage extends ConsumerWidget {
  const EstimationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final AsyncValue<Estimation?> estimation =
        ref.watch(estimationNotifierProvider);

    bool isValidName(String name) {
      return name.isNotEmpty &&
          RegExp(r"^[a-zA-ZäöüÄÖÜß]+$").hasMatch(name) &&
          !name.contains(' ');
    }

    void handleSendPressed() {
      final String name = nameController.text.trim();
      if (!isValidName(name)) {
        Snackbar.showCustomSnackBar(context,
            'Bitte gib einen gültigen Namen ein (nur Buchstaben, keine Leerzeichen).');
        return;
      }
      ref.read(estimationNotifierProvider.notifier).estimateAge(name);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'EstimatMe',
          style: TextStyle(color: Colors.black, fontSize: Sizes.p32),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 75,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Sizes.p64),
            const Text(
              'Gib deinen Namen ein, um das geschätzte Alter zu erfahren.',
              style: TextStyle(fontSize: Sizes.p20),
              textAlign: TextAlign.center,
            ),
            gapH48,
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        fillColor: Colors.white60,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.p16)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.p16),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
                gapW12,
                IconButton(
                  icon: Image.asset('assets/send.png',
                      width: Sizes.p32, height: Sizes.p32),
                  onPressed: handleSendPressed,
                ),
              ],
            ),
            gapH48,
            estimation.when(
              data: (data) {
                if (data == null) {
                  return Container();
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          '${data.name} ist ${data.age} Jahre alt.',
                          style: const TextStyle(
                            fontSize: Sizes.p20,
                          ),
                        ),
                      ),
                      gapH16,
                      IconButton(
                        icon: Image.asset('assets/refresh.png',
                            width: Sizes.p32, height: Sizes.p32),
                        onPressed: () {
                          nameController.clear();
                          ref
                              .read(estimationNotifierProvider.notifier)
                              .resetEstimation();
                        },
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
              error: (error, stack) => Text('Fehler: $error'),
            ),
          ],
        ),
      ),
    );
  }
}
