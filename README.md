# 2025-1 Programación Movil - Quiz
Este aplicativo móv- [Configuración del Ambiente de Desarrollo](#configuración-del-ambiente-de-desarrollo)
## Configuración del Ambiente de Desarrollo
![img01](img/android.jpg)

*Figura 1: Instalacion de Android Studio*



# Diagrama de Despliegue:

Nuestro Diagrama de despliegue muestra una arquitectura distribuida en donde el usuario interactua en una app movil (AprendeMath) que sera en diapositivos Android, donde se ejecutara un protocolo HTTPS, con un servicio de  con un servicio backend desplegado en Azure App Service, que procesa las solicitudes y ejecuta la lógica de negocio. A su vez, el backend consulta y almacena la información en una base de datos Azure SQL Database denominada "dataPrograMovil", mediante conexiones internas seguras dentro de la nube de Azure. 

![image](https://github.com/user-attachments/assets/8acf84a6-6032-4636-b2a1-5cffc47dfe4c)


*<b>Figura 2:</b> Diagrama de Despliegue*



# Requerimientos No funcionales:
Los requerimientos no funcionales definen las características de calidad que debe cumplir el aplicativo móvil AprendeMath para garantizar su correcto funcionamiento durante el desarrollo y evaluación académica.

- **Seguridad:**  
  Toda comunicación entre el móvil y el backend deben realizarse mediante el protocolo **HTTPS** garantizando la integridad y confidencialidad de los datos. Las credenciales del usuario, especialmente las contraseñas, serán cifradas. Adicionalmente se implementarán sistemas de autenticación y validación entre sesiones.

- **Rendimiento:**  
  El tiempo de respuesta de operaciones críticas (**inicio de sesión**, **carga de módulos**, **respuestas a cuestionarios**) no debe exceder los **5 segundos** bajo condiciones normales de conectividad. Asimismo, el tiempo de renderizado de las vistas principales no debe exceder **2 segundos** desde la interacción del usuario.


- **Disponibilidad:**  
  La aplicación debe garantizar una disponibilidad de al menos **99%** durante periodos normales. En caso de fallos, se debe tener la opción de realizar **reinicios manuales** en el backend para minimizar el tiempo de inactividad.

- **Usabilidad:**  
  El proceso de registro de un nuevo usuario será intuitivo, completándose en menos de **3 minutos**. Un usuario nuevo debe ser capaz de iniciar y completar su primer cuestionario en menos de **6 minutos** desde el momento de la instalación sin necesidad de asistencia externa. La navegación será fluida y con retroalimentación clara en todas las acciones.

- **Compatibilidad:**  
  La aplicación funcionará en dispositivos móviles con sistema operativo **Android 8.0** o superior. Se adaptará a dispositivos de **5 a 10 pulgadas**, procurando que no haya pérdidas en contenido o errores de diseño visual.

- **Recuperación ante errores:**  
  En caso de fallas en la conexión, la aplicación debe notificar al usuario mediante mensajes amigables e intentar reintentos automáticos de reconexión. En caso de fallas en servidores, se insistirán estos reinicios.

- **Mantenibilidad:**  
  El código fuente de la aplicación debe seguir principios de desarrollo limpio, modular y documentado, permitiendo actualizaciones rápidas y seguras.

# Diagrama de Casos de Uso:

![img02](img/Diagrama%20de%20Casos%20de%20Uso.jpg)

*<b>Figura 3:</b> Diagrama de Casos de Uso*
# Descripción de Casos de Uso:

- **Iniciar Sesión:** Permite al usuario autenticarse ingresando sus credenciales para acceder a su cuenta.
- **Registrar Cuenta:** Permite al usuario crear un nuevo registro proporcionando sus datos personales y de acceso.
- **Recuperar Contraseña:** Permite al usuario recuperar el acceso a su cuenta mediante un correo de restablecimiento de contraseña.
- **Actualizar Información Personal:** Permite al usuario modificar sus datos de perfil, como nombre, correo electrónico o foto.
- **Cambiar Módulos:** Permite al usuario seleccionar entre diferentes módulos de aprendizaje para continuar su progreso.
- **Cerrar Sesión:** Permite al usuario salir de su cuenta de forma segura, cerrando su sesión actual.
- **Responder Pregunta:** Permite al usuario seleccionar una respuesta dentro de las evaluaciones o cuestionarios.
- **Confirmar Respuesta:** Permite al usuario enviar su respuesta seleccionada y recibir retroalimentación sobre su validez.
- **Consultar Medallas:** Permite al usuario visualizar las medallas obtenidas por su rendimiento y logros alcanzados.
- **Consultar Niveles:** Permite al usuario ver los niveles o etapas superadas dentro de la aplicación educativa.

# Descripción de Casos de Uso:
