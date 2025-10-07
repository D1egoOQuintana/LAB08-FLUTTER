# 🛍️ Sistema de Comercio Electrónico - Flutter

## 📱 Descripción
Aplicación completa de comercio electrónico desarrollada en Flutter con autenticación, gestión de carrito, y configuración de usuario. Incluye 4 pantallas principales con navegación fluida y persistencia de datos.

## ✨ Características Principales

### 🔐 Pantalla de Login
- Diseño moderno con gradiente azul a morado
- Validación de formularios en tiempo real
- Sistema de "Recordar sesión" con SharedPreferences
- Animaciones de entrada (fade in)
- Toggle para mostrar/ocultar contraseña
- Credenciales de prueba:
  - **Email:** usuario@tienda.com
  - **Password:** 123456

### 🏠 Menú Principal (Home)
- AppBar con gradiente personalizado
- Avatar del usuario con inicial
- Badge de notificaciones (3 notificaciones)
- Drawer lateral con:
  - Header personalizado con avatar y email
  - Navegación a perfil y configuración
  - Opción de cerrar sesión con confirmación
- GridView de 4 categorías:
  - Electrónica
  - Ropa
  - Hogar
  - Deportes
- FloatingActionButton para ver carrito (muestra cantidad de items)

### 📦 Lista de Productos
- ListView de 8 productos de ejemplo
- Búsqueda funcional por nombre
- Pull-to-refresh para actualizar productos
- Cada producto muestra:
  - Imagen con color distintivo
  - Nombre y descripción
  - Precio formateado
  - Rating con estrellas (4.5/5.0)
  - Botón para agregar al carrito
- Bottom sheet detallado al tocar un producto
- Bottom sheet del carrito con funcionalidad completa:
  - Ver todos los productos
  - Aumentar/disminuir cantidad
  - Total calculado automáticamente

### 👤 Perfil y Configuración (2 Tabs)

#### Tab 1: Mi Perfil
- Avatar editable con opciones de cámara/galería
- Campos de información personal:
  - Nombre completo (editable)
  - Email (bloqueado, muestra el del login)
  - Teléfono (editable)
  - Dirección (multilínea, editable)
- Botón "Guardar Cambios"
- Estadísticas con 3 cards:
  - Pedidos realizados: 12
  - Productos favoritos: 5
  - Puntos acumulados: 340

#### Tab 2: Configuración
- **Apariencia:**
  - Switch de Modo Oscuro (funcional, cambia toda la app)
  - Selector de idioma (Español/English)
- **Notificaciones:**
  - Switch para activar/desactivar notificaciones
- **Privacidad y Seguridad:**
  - Política de Privacidad
  - Términos y Condiciones
- **Información:**
  - Acerca de (versión 1.0.0)
- **Zona de Peligro:**
  - Eliminar cuenta (con confirmación)

## 🛠️ Tecnologías Utilizadas

- **Flutter:** Framework principal
- **Provider:** Manejo de estado global
- **SharedPreferences:** Persistencia de sesión y configuraciones
- **Google Fonts:** Tipografía Poppins
- **Material 3:** Sistema de diseño

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada con splash screen
├── models/
│   ├── product.dart         # Modelo de productos
│   └── category.dart        # Modelo de categorías
├── providers/
│   ├── auth_provider.dart   # Gestión de autenticación
│   ├── cart_provider.dart   # Gestión del carrito
│   └── theme_provider.dart  # Gestión de tema y configuraciones
├── screens/
│   ├── login_screen.dart    # Pantalla de login
│   ├── menu_screen.dart     # Menú principal
│   ├── products_screen.dart # Lista de productos
│   └── profile_screen.dart  # Perfil y configuración
├── utils/
│   └── constants.dart       # Constantes y colores
└── widgets/
    └── (widgets reutilizables)
```

## 🚀 Instalación y Ejecución

1. **Clonar el repositorio:**
   ```bash
   git clone <url-del-repo>
   cd lab08_quintana
   ```

2. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación:**
   ```bash
   flutter run
   ```

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  shared_preferences: ^2.3.3
  google_fonts: ^6.2.1
```

## 🎨 Paleta de Colores

- **Primary Color:** `#6366F1` (Azul Índigo)
- **Secondary Color:** `#8B5CF6` (Violeta)
- **Accent Color:** `#F43F5E` (Rosa)

## 🔄 Flujo de Navegación

```
Splash Screen (2s)
    ↓
¿Sesión guardada?
    ↓              ↓
   Sí             No
    ↓              ↓
Menu Screen    Login Screen
    ↓              ↓
    ←──────────────┘
    ↓
Products Screen
    ↓
Profile Screen
```

## ✅ Funcionalidades Implementadas

- [x] Autenticación con credenciales hardcodeadas
- [x] Persistencia de sesión con SharedPreferences
- [x] Auto-login al reabrir la app
- [x] Gestión de carrito de compras
- [x] Modo oscuro funcional
- [x] Búsqueda de productos
- [x] Pull-to-refresh
- [x] Validaciones de formularios
- [x] Animaciones y transiciones
- [x] Bottom sheets y dialogs
- [x] Drawer navegacional
- [x] Diseño responsive
- [x] Material 3 design

## 📝 Notas Adicionales

- La aplicación está completamente funcional excepto por el proceso de pago (muestra mensaje de "en desarrollo")
- Los datos de productos son hardcodeados pero pueden conectarse fácilmente a una API
- Todas las configuraciones se persisten localmente
- El tema oscuro afecta toda la aplicación en tiempo real
- Las validaciones son completas y muestran mensajes en español



## 📄 Desarrollo:

Este proyecto es de código abierto para fines educativos.
Desarrollado por Luis Quintana, con ayuda de la IA 
