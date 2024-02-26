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

-Cambios a realizar próximamente:
  - Crear las interfaces para el frontend a partir de los mockUps.
  - Implementar la lógica de negocio para interactuar con las tablas creadas hasta ahora.
  - Hacer las conexiones del backend hacia el frontend con sus end points.
  - Crear las operaciones CRUD en la base de datos en Flask.