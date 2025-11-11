# 🛍️ Sistema de Comercio Electrónico - Flutter (iOS Style)

## 📱 Descripción
Aplicación completa de comercio electrónico desarrollada en **Flutter** con **diseño iOS nativo** usando widgets Cupertino. Incluye autenticación, gestión de carrito, y configuración de usuario. **100% responsiva** con tamaños adaptables a cualquier dispositivo iOS.

## ✨ Características Principales

### 🎨 Diseño iOS Nativo
- **100% Cupertino Widgets**: CupertinoApp, CupertinoPageScaffold, CupertinoNavigationBar
- **Diseño Responsivo Total**: Todos los tamaños calculados con MediaQuery (sin píxeles fijos)
- **Navegación iOS**: CupertinoPageRoute con transiciones nativas
- **Componentes iOS**: CupertinoButton, CupertinoTextField, CupertinoAlertDialog, CupertinoActivityIndicator
- **Tipografía**: Google Fonts (Poppins) integrada con CupertinoThemeData

### 🔐 Pantalla de Login (iOS Style)
- Diseño con gradiente azul a morado (fondo personalizado)
- **CupertinoTextField** con validación en tiempo real
- **CupertinoSwitch** para "Recordar sesión" con SharedPreferences
- Animaciones de entrada (FadeTransition)
- Toggle iOS para mostrar/ocultar contraseña
- **Tamaños responsivos**: Logo, textos y botones se adaptan al tamaño de pantalla
- Credenciales de prueba:
  - **Email:** usuario@tienda.com
  - **Password:** 123456

### 🏠 Menú Principal (iOS Style)
- **CupertinoNavigationBar** con título personalizado
- Avatar del usuario con inicial
- Badge de notificaciones con **CupertinoAlertDialog**
- **GridView responsivo** de 4 categorías con cards adaptables:
  - Electrónica
  - Ropa
  - Hogar
  - Deportes
- Botón flotante iOS (**CupertinoButton.filled**) para ver carrito
- Navegación con **CupertinoPageRoute** y transiciones nativas

### 📦 Lista de Productos (iOS Style)
- **CustomScrollView** con **CupertinoSliverRefreshControl** (pull-to-refresh iOS)
- **CupertinoSearchTextField** funcional para búsqueda
- Lista de 8 productos con **diseño totalmente responsivo**:
  - Tamaños de imagen, texto y botones calculados dinámicamente
  - Cards con sombras suaves estilo iOS
- Cada producto muestra:
  - Imagen con color distintivo (tamaño adaptable)
  - Nombre y descripción (texto responsivo)
  - Precio formateado
  - Rating con **CupertinoIcons.star_fill**
  - **CupertinoButton** circular para agregar al carrito
- **CupertinoAlertDialog** al agregar productos
- **showCupertinoModalPopup** para detalles del producto
- Botón de carrito flotante con **CupertinoButton.filled**

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

- **Flutter**: Framework principal con **Cupertino Widgets**
- **Provider**: Manejo de estado global (compatible con Cupertino)
- **SharedPreferences**: Persistencia de sesión y configuraciones
- **Google Fonts**: Tipografía Poppins integrada con CupertinoThemeData
- **Cupertino Icons**: Iconografía nativa de iOS
- **Diseño 100% Responsivo**: MediaQuery para tamaños adaptativos

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
   cd LAB08-FLUTTER
   ```

2. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación (recomendado: simulador iOS):**
   ```bash
   flutter run
   ```

4. **Verificar código:**
   ```bash
   flutter analyze
   ```

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8      # Iconos iOS nativos
  provider: ^6.1.2              # Estado global
  shared_preferences: ^2.3.3    # Persistencia local
  google_fonts: ^6.2.1          # Tipografía Poppins
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

- [x] **Diseño iOS nativo** con Cupertino widgets (CupertinoApp, CupertinoPageScaffold)
- [x] **100% Responsivo** - tamaños adaptables con MediaQuery (sin píxeles fijos)
- [x] Autenticación con credenciales hardcodeadas
- [x] Persistencia de sesión con SharedPreferences
- [x] Auto-login al reabrir la app
- [x] Gestión de carrito de compras (Provider)
- [x] Modo oscuro funcional (CupertinoThemeData con Brightness)
- [x] Búsqueda de productos (**CupertinoSearchTextField**)
- [x] Pull-to-refresh iOS (**CupertinoSliverRefreshControl**)
- [x] Validaciones de formularios
- [x] Animaciones y transiciones iOS (**CupertinoPageRoute**)
- [x] **CupertinoAlertDialog** y **showCupertinoModalPopup**
- [x] Navegación con **CupertinoNavigationBar**
- [x] **CupertinoButton**, **CupertinoTextField**, **CupertinoSwitch**
- [x] Iconos nativos iOS (**CupertinoIcons**)

## 📝 Notas Adicionales

- La aplicación está diseñada **100% para iOS** con widgets Cupertino
- **Totalmente responsiva**: todos los tamaños (texto, íconos, cards) se calculan con MediaQuery
- Sin tamaños fijos en píxeles - se adapta a cualquier iPhone/iPad
- Los datos de productos son hardcodeados pero pueden conectarse fácilmente a una API
- Todas las configuraciones se persisten localmente
- El tema oscuro afecta toda la aplicación en tiempo real
- Las validaciones muestran mensajes en español
- **4 pantallas migradas a Cupertino**: main.dart (splash), login_screen, products_screen, menu_screen
- profile_screen mantiene diseño Material (omitido según instrucciones)

## 🎯 Migración Cupertino Completada

### Widgets Material → Cupertino:
- ✅ `MaterialApp` → `CupertinoApp`
- ✅ `Scaffold` → `CupertinoPageScaffold`
- ✅ `AppBar` → `CupertinoNavigationBar`
- ✅ `TextField` → `CupertinoTextField`
- ✅ `ElevatedButton` → `CupertinoButton` / `CupertinoButton.filled`
- ✅ `FloatingActionButton` → `CupertinoButton.filled` (positioned)
- ✅ `CircularProgressIndicator` → `CupertinoActivityIndicator`
- ✅ `AlertDialog` → `CupertinoAlertDialog`
- ✅ `showModalBottomSheet` → `showCupertinoModalPopup`
- ✅ `RefreshIndicator` → `CupertinoSliverRefreshControl`
- ✅ `Checkbox` → `CupertinoSwitch`
- ✅ `SnackBar` → `CupertinoAlertDialog`
- ✅ `Icons.*` → `CupertinoIcons.*`



## 📄 Desarrollo:

Este proyecto es de código abierto para fines educativos.
Desarrollado por Luis Quintana, con ayuda de la IA 
