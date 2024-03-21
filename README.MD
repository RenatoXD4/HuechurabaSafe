"Proyecto de la Municipalidad de Huechuraba"


CHANGE LOG

VERSIÓN 0.0.1 - [26-02-2024]

- Creación del frontend utilizando Flutter.
- Desarrollo del backend con Flask.
- Utilización de MariaDB como gestor de base de datos.
- Creación de la tabla de conductor en el backend.

- Creación de la tabla de conductor en el backend con las siguientes columnas:
  - id (Integer, Primary Key)
  - nombre_conductor (String, Not Null)
  - patente (String, Unique, Not Null)
  - nombre_vehiculo (String, Not Null)
  Nota: Estas tablas pueden cambiar en un futuro, en caso de que cambien los requisitos actuales.

- Se adoptó la decisión de utilizar claves primarias y únicas en la tabla de conductor para garantizar la integridad de los datos.

- Cambios a realizar próximamente:
  - Crear las interfaces para el frontend a partir de los mockUps.
  - Implementar la lógica de negocio para interactuar con las tablas creadas hasta ahora.
  - Hacer las conexiones del backend hacia el frontend con sus end points.
  - Crear las operaciones CRUD en la base de datos en Flask.


VERSIÓN 0.0.2 - [20-03-2024]

- Creación de la base de datos con 2 tablas más:
  - Tabla de Usuario:
      - ID
      - username
      - email
      - ID_ROL

    - Tabla de Rol:
      - ID
      - Nombre_Rol

- Se modificó la tabla de conductor para guardar fotos y obtenerlas desde la base de datos.
- Se completa la API de las 3 tablas. Conductor, Usuario y Rol.

- Se creó parte del diseño. Específicamente:
  - El perfil del conductor.
  - Barra de navegación.
  - Formulario para buscar la patente del auto.
  
- Cambios a realizar próximamente:
  - Crear formulario de creación de cuenta de Usuario y Login.
  - Validar todos los formularios.
  - Hacer el routing en el frontend.
  - Conectar el frontend con el backend para hacer solicitudes CRUD.
  - Implementación del QR para buscar por patente.
  - Pestaña de Administrador con los conductores registrados.
  - Temas de seguridad(Hasheo de contraseñas, proteger rutas, recuperar contraseña, etc).


 


