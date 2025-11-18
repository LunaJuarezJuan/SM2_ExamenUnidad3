# 📱 Acees Group - Sistema de Control de Acceso NFC

Sistema completo de control de acceso con tecnología NFC desarrollado en Flutter con arquitectura MVVM.


Entrega del informe (Readme.md convertido a PDF)
El informe debe estar realizado en el propio README.md del proyecto y debe contener lo siguiente:
•	Soluciones Moviles II
•   Fecha: 18/11/2025, 
•   Presentado por: Juan Brendon Luna Juarez.
•	URL del repositorio:https://github.com/LunaJuarezJuan/SM2_ExamenUnidad3.git
•	Capturas de pantalla que evidencien:
o	Estructura de carpetas .github/workflows/.
        ![alt text](imgs/image1.png)
o	Contenido del archivo quality-check.yml.
        ![alt text](imgs/image2.png)
o	Ejecución del flutter test previa subida a Actions.
        ![alt text](imgs/image3.png)
o	Ejecución del workflow en la pestaña Actions.


•	Explicación de lo realizado:
<!-- Se añade explicación detallada a continuación -->
Se implementaron las siguientes acciones para cumplir con los requisitos del examen y permitir pruebas automatizadas:

- Se añadió un workflow de GitHub Actions en `.github/workflows/quality-check.yml` que:
  - Se ejecuta en push y pull_request sobre la rama `main`.
  - Instala Flutter, ejecuta `flutter pub get`, luego `flutter analyze` y `flutter test`.
  - Permite validar automáticamente el código y las pruebas en cada cambio.

- Se agregó la carpeta `test/` con `test/main_test.dart` que contiene al menos 3 pruebas unitarias/widget:
  - Prueba de renderizado de la vista de login (títulos y campos).
  - Prueba que muestra el mensaje de error cuando el auth devuelve un error.
  - Prueba que verifica que se llame al método `login` del objeto de autenticación inyectado.

- Se modificó `lib/views/login_view.dart` para facilitar pruebas:
  - Se introdujo un parámetro opcional `authOverride` en `LoginView` que permite inyectar un objeto "fake" de autenticación en tests.
  - Esto evita depender del `Provider` real durante los widget tests y permite verificar `isLoading`, `errorMessage` y la llamada a `login`.

- Cómo verificar localmente y en GitHub:
  - Local: ejecutar `flutter pub get`, luego `flutter analyze` y `flutter test`.
  - GitHub: hacer push a `main` o abrir un PR hacia `main`; revisar la pestaña "Actions" → seleccionar "Quality Check" para ver pasos y resultados.
  - El objetivo del entregable es que el workflow muestre todos los pasos con estado "passed".


Consideraciones finales:
- Asegúrate de que el repositorio sea público y que los archivos añadidos estén en las rutas correctas (`.github/workflows/quality-check.yml`, `test/main_test.dart`).
- Si cambias nombres de paquete, ajusta imports en los tests (`package:...`) según `pubspec.yaml`.



