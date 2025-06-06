import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/pages/editar_perfil/editar_perfil.dart';
import 'package:prueba_seminario1/pages/perfil/perfil_controller.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PaginaPerfilState();
}

class _PaginaPerfilState extends State<Perfil> {
  final sesion = Get.find<SesionController>();
  final PerfilController control = Get.put(PerfilController());
  bool mostrarMenu = false;

  @override
  void initState() {
    super.initState();
    control.initialFetch();
  }

  Widget _buildCerrarSesionCard() {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0XFFEAD9B5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text("¿Cerrar sesión?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => setState(() => mostrarMenu = false),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text("Cancelar"),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  sesion.limpiarSesion();
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text("Cerrar sesión", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = sesion.getUsuario;
    if (usuario == null) {
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const Scaffold();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEBD49C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Stack(
            children: [
              Column(
                children: [
                  mostrarMenu
                      ? _buildCerrarSesionCard()
                      : Container(
                          height: 200,
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0XFFEAD9B5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Usuario: ${usuario.nombre}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                    ),
                                    Text('Género: ${usuario.idgenero}',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    Text('Edad: ${usuario.edad}',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    Text('Experiencia: ${usuario.experiencia} XP',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.person, size: 80),
                            ],
                          ),
                        ),
                  const SizedBox(height: 10),
                  boton(
                    data: "Editar",
                    onPressed: () async {
                      final usuarioEditado = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarUsuarioPage(usuario: usuario),
                        ),
                      );
                      if (usuarioEditado != null) {
                        sesion.setUsuario(usuarioEditado);
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Ranking de Usuarios",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Obx(() {
                      final lista = control.usuarios;
                      if (lista.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        itemCount: lista.length,
                        itemBuilder: (context, index) {
                          final user = lista[index];
                          return Card(
                            color: const Color(0XFFEAD9B5),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Text('${index + 1}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                              title: Text(user.nombre,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                              subtitle: Text('Edad: ${user.edad}, Género: ${user.idgenero}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              trailing: Text('${user.experiencia} XP',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    setState(() {
                      mostrarMenu = !mostrarMenu;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
