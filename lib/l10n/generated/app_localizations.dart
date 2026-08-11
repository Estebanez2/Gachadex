import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// Nombre visible de la aplicacion.
  ///
  /// In es, this message translates to:
  /// **'Gachadex'**
  String get appTitle;

  /// Etiqueta de la seccion principal.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get home;

  /// Etiqueta de la seccion de colecciones.
  ///
  /// In es, this message translates to:
  /// **'Colecciones'**
  String get collections;

  /// Etiqueta de la seccion de creacion.
  ///
  /// In es, this message translates to:
  /// **'Crear'**
  String get create;

  /// Etiqueta de la seccion de ajustes.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settings;

  /// Titulo del selector de tema.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get theme;

  /// Opcion para usar el tema del sistema.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get system;

  /// Opcion para usar tema claro.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get light;

  /// Opcion para usar tema oscuro.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get dark;

  /// Etiqueta de accion para volver a intentar una operacion.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// Titulo seguro para errores de presentacion.
  ///
  /// In es, this message translates to:
  /// **'No se ha podido mostrar esta pantalla.'**
  String get screenErrorTitle;

  /// Estado vacio de la pantalla Colecciones.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay colecciones.'**
  String get noCollections;

  /// Etiqueta para funciones aun no disponibles.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get comingSoon;

  /// Mensaje provisional de la pantalla Inicio.
  ///
  /// In es, this message translates to:
  /// **'Aquí aparecerán los sobres disponibles.'**
  String get homePackMessage;

  /// Descripcion del estado vacio de colecciones.
  ///
  /// In es, this message translates to:
  /// **'Aquí aparecerán las colecciones instaladas y los proyectos creados.'**
  String get collectionsEmptyDescription;

  /// Descripcion provisional de la pantalla Crear.
  ///
  /// In es, this message translates to:
  /// **'Aquí se crearán colecciones cuando la fase de creador esté lista.'**
  String get createDescription;

  /// Titulo de la pantalla de error controlado.
  ///
  /// In es, this message translates to:
  /// **'Error controlado'**
  String get controlledError;

  /// Descripcion segura del error controlado.
  ///
  /// In es, this message translates to:
  /// **'Esta pantalla comprueba que los errores se muestran con un mensaje seguro.'**
  String get controlledErrorDescription;

  /// Boton para abrir la ruta de error controlado.
  ///
  /// In es, this message translates to:
  /// **'Ver error controlado'**
  String get openControlledError;

  /// Tooltip del boton que abre el error controlado.
  ///
  /// In es, this message translates to:
  /// **'Abre la pantalla de error controlado'**
  String get openControlledErrorTooltip;

  /// Titulo para rutas desconocidas.
  ///
  /// In es, this message translates to:
  /// **'Página no encontrada'**
  String get notFoundTitle;

  /// Descripcion segura de pagina no encontrada.
  ///
  /// In es, this message translates to:
  /// **'La ruta solicitada no existe en Gachadex.'**
  String get notFoundDescription;

  /// Etiqueta accesible del estado de carga.
  ///
  /// In es, this message translates to:
  /// **'Cargando'**
  String get loading;

  /// Titulo de la informacion basica de la app.
  ///
  /// In es, this message translates to:
  /// **'Información de la aplicación'**
  String get appInfo;

  /// Estado actual del proyecto.
  ///
  /// In es, this message translates to:
  /// **'Fase 1: base técnica ejecutable.'**
  String get phaseOneStatus;

  /// Nota sobre la persistencia futura del tema.
  ///
  /// In es, this message translates to:
  /// **'La preferencia de tema se mantiene durante la sesión. La persistencia llegará cuando exista infraestructura local.'**
  String get themeSessionOnly;

  /// Titulo del ajuste de notificaciones de sobres.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones de sobres'**
  String get packNotifications;

  /// Descripcion del ajuste cuando las notificaciones estan activadas.
  ///
  /// In es, this message translates to:
  /// **'Te avisaremos cuando un sobre vuelva a estar disponible.'**
  String get packNotificationsEnabledDescription;

  /// Descripcion del ajuste cuando las notificaciones estan desactivadas.
  ///
  /// In es, this message translates to:
  /// **'No se programaran avisos de recarga de sobres.'**
  String get packNotificationsDisabledDescription;

  /// Mensaje seguro cuando falla el ajuste de notificaciones.
  ///
  /// In es, this message translates to:
  /// **'No se pudo leer la preferencia de notificaciones.'**
  String get packNotificationsError;

  /// Boton para abrir los ajustes del sistema de notificaciones.
  ///
  /// In es, this message translates to:
  /// **'Abrir ajustes de notificaciones'**
  String get openNotificationSettings;

  /// Boton deshabilitado de creacion futura.
  ///
  /// In es, this message translates to:
  /// **'Crear colección'**
  String get createDisabledAction;

  /// Resumen de la biblioteca de borradores.
  ///
  /// In es, this message translates to:
  /// **'Prepara colecciones locales y retoma cualquier borrador sin perder cambios.'**
  String get collectionDraftsDescription;

  /// Accion para crear un borrador.
  ///
  /// In es, this message translates to:
  /// **'Nueva colección'**
  String get newCollection;

  /// Titulo de creacion de borrador.
  ///
  /// In es, this message translates to:
  /// **'Crear colección'**
  String get createCollection;

  /// Nombre seguro mostrado cuando el borrador no tiene nombre.
  ///
  /// In es, this message translates to:
  /// **'Colección sin nombre'**
  String get unnamedCollection;

  /// Indicador de estado draft.
  ///
  /// In es, this message translates to:
  /// **'Borrador'**
  String get draft;

  /// Seccion de informacion general.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get information;

  /// Seccion de rarezas.
  ///
  /// In es, this message translates to:
  /// **'Rarezas'**
  String get rarities;

  /// Seccion futura de cartas.
  ///
  /// In es, this message translates to:
  /// **'Cartas'**
  String get cards;

  /// Seccion futura de sobres.
  ///
  /// In es, this message translates to:
  /// **'Sobres'**
  String get packs;

  /// Seccion futura de revision.
  ///
  /// In es, this message translates to:
  /// **'Revisión'**
  String get review;

  /// Etiqueta generica para nombre.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get name;

  /// Campo de nombre de coleccion.
  ///
  /// In es, this message translates to:
  /// **'Nombre de colección'**
  String get collectionName;

  /// Campo de autor.
  ///
  /// In es, this message translates to:
  /// **'Autor'**
  String get author;

  /// Campo de descripcion.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get description;

  /// Seccion de portada.
  ///
  /// In es, this message translates to:
  /// **'Portada'**
  String get cover;

  /// Estado de guardado pendiente.
  ///
  /// In es, this message translates to:
  /// **'Cambios pendientes'**
  String get savePending;

  /// Estado de guardado en progreso.
  ///
  /// In es, this message translates to:
  /// **'Guardando...'**
  String get saving;

  /// Estado de guardado correcto.
  ///
  /// In es, this message translates to:
  /// **'Guardado'**
  String get saved;

  /// Estado de error al guardar.
  ///
  /// In es, this message translates to:
  /// **'No se han podido guardar los cambios'**
  String get saveError;

  /// Estado de error por validacion local.
  ///
  /// In es, this message translates to:
  /// **'Corrige los campos para guardar'**
  String get fixFieldsToSave;

  /// Accion para crear rareza.
  ///
  /// In es, this message translates to:
  /// **'Añadir rareza'**
  String get addRarity;

  /// Accion para editar rareza.
  ///
  /// In es, this message translates to:
  /// **'Editar rareza'**
  String get editRarity;

  /// Accion para eliminar rareza.
  ///
  /// In es, this message translates to:
  /// **'Eliminar rareza'**
  String get deleteRarity;

  /// Campo de valor de venta por rareza.
  ///
  /// In es, this message translates to:
  /// **'Valor de venta'**
  String get sellValue;

  /// Etiqueta de selector de color.
  ///
  /// In es, this message translates to:
  /// **'Color'**
  String get color;

  /// Etiqueta de color principal.
  ///
  /// In es, this message translates to:
  /// **'Color principal'**
  String get primaryColor;

  /// Etiqueta de color secundario.
  ///
  /// In es, this message translates to:
  /// **'Color secundario'**
  String get accentColor;

  /// Etiqueta de selector de icono.
  ///
  /// In es, this message translates to:
  /// **'Icono'**
  String get icon;

  /// Etiqueta de selector de marco.
  ///
  /// In es, this message translates to:
  /// **'Marco'**
  String get frame;

  /// Etiqueta de selector de efecto.
  ///
  /// In es, this message translates to:
  /// **'Efecto'**
  String get effect;

  /// Etiqueta de estilo de portada.
  ///
  /// In es, this message translates to:
  /// **'Estilo'**
  String get style;

  /// Etiqueta de orden.
  ///
  /// In es, this message translates to:
  /// **'Orden'**
  String get order;

  /// Accion accesible para subir una rareza.
  ///
  /// In es, this message translates to:
  /// **'Subir'**
  String get moveUp;

  /// Accion accesible para bajar una rareza.
  ///
  /// In es, this message translates to:
  /// **'Bajar'**
  String get moveDown;

  /// Accion para cancelar.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// Accion para guardar.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// Accion para eliminar.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// Accion para eliminar borrador.
  ///
  /// In es, this message translates to:
  /// **'Eliminar borrador'**
  String get deleteDraft;

  /// Titulo del estado vacio de borradores.
  ///
  /// In es, this message translates to:
  /// **'Todavía no has creado ninguna colección'**
  String get emptyDraftsTitle;

  /// Descripcion del estado vacio de borradores.
  ///
  /// In es, this message translates to:
  /// **'Crea un borrador para empezar a preparar tus cartas y rarezas.'**
  String get emptyDraftsDescription;

  /// Accion para abrir un borrador.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get continueEditing;

  /// Numero de rarezas de un borrador.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin rarezas} =1{1 rareza} other{{count} rarezas}}'**
  String rarityCount(int count);

  /// Fecha de ultima modificacion.
  ///
  /// In es, this message translates to:
  /// **'Última edición: {date}'**
  String lastUpdated(String date);

  /// Estado general incompleto.
  ///
  /// In es, this message translates to:
  /// **'Borrador incompleto'**
  String get incompleteDraft;

  /// Estado completo dentro de la fase actual.
  ///
  /// In es, this message translates to:
  /// **'Completo para esta fase'**
  String get completeForThisPhase;

  /// Estado no iniciado.
  ///
  /// In es, this message translates to:
  /// **'No iniciado'**
  String get notStarted;

  /// Estado incompleto.
  ///
  /// In es, this message translates to:
  /// **'Incompleto'**
  String get incomplete;

  /// Estado con errores.
  ///
  /// In es, this message translates to:
  /// **'Con errores'**
  String get withErrors;

  /// Estado pendiente.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get pending;

  /// Requisito de completitud de nombre.
  ///
  /// In es, this message translates to:
  /// **'La colección necesita un nombre'**
  String get collectionNeedsName;

  /// Requisito de completitud de rarezas.
  ///
  /// In es, this message translates to:
  /// **'Debe existir al menos una rareza'**
  String get atLeastOneRarity;

  /// Etiqueta de funciones futuras.
  ///
  /// In es, this message translates to:
  /// **'Disponible más adelante'**
  String get availableLater;

  /// Error de borrador no encontrado.
  ///
  /// In es, this message translates to:
  /// **'No se ha encontrado este borrador.'**
  String get projectNotFound;

  /// Accion para volver a biblioteca de borradores.
  ///
  /// In es, this message translates to:
  /// **'Volver a borradores'**
  String get backToDrafts;

  /// Titulo de confirmacion de borrador.
  ///
  /// In es, this message translates to:
  /// **'Eliminar borrador'**
  String get deleteDraftDialogTitle;

  /// Descripcion de confirmacion de borrador.
  ///
  /// In es, this message translates to:
  /// **'Se eliminará este borrador y toda su configuración local. Esta acción no se puede deshacer.'**
  String get deleteDraftDialogDescription;

  /// Confirmacion de borrador eliminado.
  ///
  /// In es, this message translates to:
  /// **'Borrador eliminado'**
  String get draftDeleted;

  /// Titulo de confirmacion de rareza.
  ///
  /// In es, this message translates to:
  /// **'Eliminar rareza'**
  String get deleteRarityDialogTitle;

  /// Descripcion de confirmacion de rareza.
  ///
  /// In es, this message translates to:
  /// **'No podrás recuperar esta rareza después de eliminarla.'**
  String get deleteRarityDialogDescription;

  /// Error al eliminar rareza usada.
  ///
  /// In es, this message translates to:
  /// **'No puedes eliminar esta rareza porque está asignada a una o más cartas.'**
  String get rarityInUse;

  /// Confirmacion de rareza eliminada.
  ///
  /// In es, this message translates to:
  /// **'Rareza eliminada'**
  String get rarityDeleted;

  /// Confirmacion de rareza guardada.
  ///
  /// In es, this message translates to:
  /// **'Rareza guardada'**
  String get raritySaved;

  /// Titulo de estado vacio de rarezas.
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay rarezas'**
  String get noRaritiesTitle;

  /// Descripcion de estado vacio de rarezas.
  ///
  /// In es, this message translates to:
  /// **'Añade al menos una rareza para completar esta parte del borrador.'**
  String get noRaritiesDescription;

  /// Error de longitud de campo.
  ///
  /// In es, this message translates to:
  /// **'Has superado el máximo permitido'**
  String get fieldTooLong;

  /// Error de nombre obligatorio de rareza.
  ///
  /// In es, this message translates to:
  /// **'Escribe un nombre para la rareza'**
  String get rarityNameRequired;

  /// Error de nombre duplicado de rareza.
  ///
  /// In es, this message translates to:
  /// **'Ya existe una rareza con ese nombre'**
  String get duplicateRarityName;

  /// Error de valor de venta invalido.
  ///
  /// In es, this message translates to:
  /// **'Introduce un valor entre 0 y 999999'**
  String get sellValueInvalid;

  /// Error de opcion visual invalida.
  ///
  /// In es, this message translates to:
  /// **'Elige una opción del catálogo'**
  String get invalidVisualOption;

  /// Contador de caracteres.
  ///
  /// In es, this message translates to:
  /// **'{count}/{max}'**
  String charactersCounter(int count, int max);

  /// Estado activo de una rareza.
  ///
  /// In es, this message translates to:
  /// **'Activa'**
  String get enabled;

  /// Estado desactivado de una rareza.
  ///
  /// In es, this message translates to:
  /// **'Desactivada'**
  String get disabled;

  /// Color de portada.
  ///
  /// In es, this message translates to:
  /// **'Verde agua'**
  String get coverColorTeal;

  /// Color de portada.
  ///
  /// In es, this message translates to:
  /// **'Coral'**
  String get coverColorCoral;

  /// Color de portada.
  ///
  /// In es, this message translates to:
  /// **'Dorado'**
  String get coverColorGold;

  /// Color de portada.
  ///
  /// In es, this message translates to:
  /// **'Lila'**
  String get coverColorLilac;

  /// Color de portada.
  ///
  /// In es, this message translates to:
  /// **'Azul cielo'**
  String get coverColorSky;

  /// Color de portada.
  ///
  /// In es, this message translates to:
  /// **'Menta'**
  String get coverColorMint;

  /// Color de portada.
  ///
  /// In es, this message translates to:
  /// **'Rosa'**
  String get coverColorRose;

  /// Color de portada.
  ///
  /// In es, this message translates to:
  /// **'Grafito'**
  String get coverColorGraphite;

  /// Icono de portada.
  ///
  /// In es, this message translates to:
  /// **'Destello'**
  String get coverIconSpark;

  /// Icono de portada.
  ///
  /// In es, this message translates to:
  /// **'Cartas'**
  String get coverIconCards;

  /// Icono de portada.
  ///
  /// In es, this message translates to:
  /// **'Risa'**
  String get coverIconLaugh;

  /// Icono de portada.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get coverIconCamera;

  /// Icono de portada.
  ///
  /// In es, this message translates to:
  /// **'Grupo'**
  String get coverIconGroup;

  /// Icono de portada.
  ///
  /// In es, this message translates to:
  /// **'Trofeo'**
  String get coverIconTrophy;

  /// Patron de portada.
  ///
  /// In es, this message translates to:
  /// **'Liso'**
  String get coverPatternSolid;

  /// Patron de portada.
  ///
  /// In es, this message translates to:
  /// **'Diagonal'**
  String get coverPatternDiagonal;

  /// Patron de portada.
  ///
  /// In es, this message translates to:
  /// **'Puntos'**
  String get coverPatternDots;

  /// Patron de portada.
  ///
  /// In es, this message translates to:
  /// **'Bicolor'**
  String get coverPatternSplit;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Gris'**
  String get rarityColorGray;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Verde'**
  String get rarityColorGreen;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Azul'**
  String get rarityColorBlue;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Morado'**
  String get rarityColorPurple;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Rojo'**
  String get rarityColorRed;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Naranja'**
  String get rarityColorOrange;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Rosa'**
  String get rarityColorPink;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Dorado'**
  String get rarityColorGold;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Turquesa'**
  String get rarityColorTurquoise;

  /// Color de rareza.
  ///
  /// In es, this message translates to:
  /// **'Grafito'**
  String get rarityColorGraphite;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Estrella'**
  String get rarityIconStar;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Corona'**
  String get rarityIconCrown;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Diamante'**
  String get rarityIconDiamond;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Fuego'**
  String get rarityIconFire;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Rayo'**
  String get rarityIconBolt;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Cohete'**
  String get rarityIconRocket;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Gafas'**
  String get rarityIconGlasses;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Trofeo'**
  String get rarityIconTrophy;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Fantasma'**
  String get rarityIconGhost;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Huella'**
  String get rarityIconFootprint;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Sonrisa'**
  String get rarityIconSmile;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Explosión'**
  String get rarityIconBurst;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Corazón'**
  String get rarityIconHeart;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Luna'**
  String get rarityIconMoon;

  /// Icono de rareza.
  ///
  /// In es, this message translates to:
  /// **'Sol'**
  String get rarityIconSun;

  /// Marco de rareza.
  ///
  /// In es, this message translates to:
  /// **'Simple'**
  String get rarityFrameSimple;

  /// Marco de rareza.
  ///
  /// In es, this message translates to:
  /// **'Redondeado'**
  String get rarityFrameRounded;

  /// Marco de rareza.
  ///
  /// In es, this message translates to:
  /// **'Doble línea'**
  String get rarityFrameDouble;

  /// Marco de rareza.
  ///
  /// In es, this message translates to:
  /// **'Metálico'**
  String get rarityFrameMetallic;

  /// Marco de rareza.
  ///
  /// In es, this message translates to:
  /// **'Neón'**
  String get rarityFrameNeon;

  /// Marco de rareza.
  ///
  /// In es, this message translates to:
  /// **'Cómico'**
  String get rarityFrameComic;

  /// Marco de rareza.
  ///
  /// In es, this message translates to:
  /// **'Elegante'**
  String get rarityFrameElegant;

  /// Marco de rareza.
  ///
  /// In es, this message translates to:
  /// **'Pixelado'**
  String get rarityFramePixel;

  /// Efecto de rareza.
  ///
  /// In es, this message translates to:
  /// **'Ninguno'**
  String get rarityEffectNone;

  /// Efecto de rareza.
  ///
  /// In es, this message translates to:
  /// **'Brillo suave'**
  String get rarityEffectSoftGlow;

  /// Efecto de rareza.
  ///
  /// In es, this message translates to:
  /// **'Destello'**
  String get rarityEffectSpark;

  /// Efecto de rareza.
  ///
  /// In es, this message translates to:
  /// **'Gradiente'**
  String get rarityEffectGradient;

  /// Efecto de rareza.
  ///
  /// In es, this message translates to:
  /// **'Holográfico simulado'**
  String get rarityEffectHolo;

  /// Efecto de rareza.
  ///
  /// In es, this message translates to:
  /// **'Pulso'**
  String get rarityEffectPulse;

  /// Accion para crear una carta.
  ///
  /// In es, this message translates to:
  /// **'AÃ±adir carta'**
  String get addCard;

  /// Accion para editar una carta.
  ///
  /// In es, this message translates to:
  /// **'Editar carta'**
  String get editCard;

  /// Accion para eliminar una carta.
  ///
  /// In es, this message translates to:
  /// **'Eliminar carta'**
  String get deleteCard;

  /// Accion para seleccionar fotografia.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar fotografÃ­a'**
  String get selectPhoto;

  /// Accion para sustituir fotografia.
  ///
  /// In es, this message translates to:
  /// **'Cambiar fotografÃ­a'**
  String get changePhoto;

  /// Seccion de fotografia.
  ///
  /// In es, this message translates to:
  /// **'FotografÃ­a'**
  String get photo;

  /// Estado de procesamiento de imagen.
  ///
  /// In es, this message translates to:
  /// **'Procesando imagen...'**
  String get processingImage;

  /// Error de fotografia obligatoria.
  ///
  /// In es, this message translates to:
  /// **'La fotografÃ­a es obligatoria'**
  String get photoRequired;

  /// Seccion de datos principales de carta.
  ///
  /// In es, this message translates to:
  /// **'Datos principales'**
  String get mainData;

  /// Campo de vida de carta.
  ///
  /// In es, this message translates to:
  /// **'Vida'**
  String get health;

  /// Numero visible de coleccion de carta.
  ///
  /// In es, this message translates to:
  /// **'NÃºmero'**
  String get collectionNumber;

  /// Campo de rareza de carta.
  ///
  /// In es, this message translates to:
  /// **'Rareza'**
  String get rarity;

  /// Campo de plantilla de carta.
  ///
  /// In es, this message translates to:
  /// **'Plantilla'**
  String get template;

  /// Seccion de apariencia de carta.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get appearance;

  /// Seccion de campos comicos de carta.
  ///
  /// In es, this message translates to:
  /// **'Campos cÃ³micos'**
  String get comicFields;

  /// Accion para anadir campo comico.
  ///
  /// In es, this message translates to:
  /// **'AÃ±adir campo'**
  String get addComicField;

  /// Valor de campo comico.
  ///
  /// In es, this message translates to:
  /// **'Valor'**
  String get value;

  /// Seccion de previsualizacion de carta.
  ///
  /// In es, this message translates to:
  /// **'PrevisualizaciÃ³n'**
  String get preview;

  /// Error de nombre obligatorio de carta.
  ///
  /// In es, this message translates to:
  /// **'Escribe un nombre para la carta'**
  String get cardNameRequired;

  /// Error de vida invalida.
  ///
  /// In es, this message translates to:
  /// **'Introduce una vida entre 1 y 9999'**
  String get healthInvalid;

  /// Error de numero de carta invalido.
  ///
  /// In es, this message translates to:
  /// **'Introduce un nÃºmero positivo'**
  String get collectionNumberInvalid;

  /// Error de numero de carta duplicado.
  ///
  /// In es, this message translates to:
  /// **'Ese nÃºmero ya estÃ¡ utilizado'**
  String get collectionNumberUsed;

  /// Error de rareza obligatoria.
  ///
  /// In es, this message translates to:
  /// **'Elige una rareza'**
  String get rarityRequired;

  /// Error generico de carta invalida.
  ///
  /// In es, this message translates to:
  /// **'Corrige la carta antes de guardarla'**
  String get cardInvalid;

  /// Confirmacion de carta eliminada.
  ///
  /// In es, this message translates to:
  /// **'Carta eliminada'**
  String get cardDeleted;

  /// Confirmacion de eliminacion de carta.
  ///
  /// In es, this message translates to:
  /// **'Se eliminarÃ¡ esta carta y su fotografÃ­a. Esta acciÃ³n no se puede deshacer.'**
  String get deleteCardDialogDescription;

  /// Titulo de confirmacion de cambios sin guardar.
  ///
  /// In es, this message translates to:
  /// **'Cambios sin guardar'**
  String get unsavedChanges;

  /// Accion para descartar cambios.
  ///
  /// In es, this message translates to:
  /// **'Descartar cambios'**
  String get discardChanges;

  /// Pregunta de confirmacion de cambios sin guardar.
  ///
  /// In es, this message translates to:
  /// **'Hay cambios sin guardar. Â¿Quieres descartarlos?'**
  String get discardChangesQuestion;

  /// Titulo de estado vacio de cartas.
  ///
  /// In es, this message translates to:
  /// **'TodavÃ­a no hay cartas'**
  String get noCardsTitle;

  /// Descripcion de estado vacio de cartas.
  ///
  /// In es, this message translates to:
  /// **'Crea la primera carta de esta colecciÃ³n.'**
  String get noCardsDescription;

  /// Requisito de completitud de cartas.
  ///
  /// In es, this message translates to:
  /// **'Debe existir al menos una carta'**
  String get atLeastOneCard;

  /// Accion para volver al borrador abierto.
  ///
  /// In es, this message translates to:
  /// **'Volver al borrador'**
  String get backToDraft;

  /// Accion para crear un tipo de sobre.
  ///
  /// In es, this message translates to:
  /// **'AÃ±adir sobre'**
  String get addPack;

  /// Accion para editar un tipo de sobre.
  ///
  /// In es, this message translates to:
  /// **'Editar sobre'**
  String get editPack;

  /// Accion para eliminar un tipo de sobre.
  ///
  /// In es, this message translates to:
  /// **'Eliminar sobre'**
  String get deletePack;

  /// Descripcion de confirmacion para eliminar sobre.
  ///
  /// In es, this message translates to:
  /// **'Se eliminarÃ¡ este sobre, sus cartas elegibles, reglas y probabilidades.'**
  String get deletePackDescription;

  /// Confirmacion de sobre eliminado.
  ///
  /// In es, this message translates to:
  /// **'Sobre eliminado'**
  String get packDeleted;

  /// Confirmacion de sobre guardado.
  ///
  /// In es, this message translates to:
  /// **'Sobre guardado'**
  String get packSaved;

  /// Requisito de completitud de sobres.
  ///
  /// In es, this message translates to:
  /// **'Debe existir al menos un sobre'**
  String get atLeastOnePack;

  /// Titulo de estado vacio de sobres.
  ///
  /// In es, this message translates to:
  /// **'TodavÃ­a no hay sobres'**
  String get noPacksTitle;

  /// Descripcion de estado vacio de sobres.
  ///
  /// In es, this message translates to:
  /// **'Crea un sobre para configurar cartas elegibles y probabilidades.'**
  String get noPacksDescription;

  /// Etiqueta de sobre principal.
  ///
  /// In es, this message translates to:
  /// **'Sobre principal'**
  String get mainPack;

  /// Etiqueta de sobre no principal.
  ///
  /// In es, this message translates to:
  /// **'Sobre secundario'**
  String get packSecondary;

  /// Campo de cantidad de cartas por sobre.
  ///
  /// In es, this message translates to:
  /// **'Cartas por sobre'**
  String get cardsPerPack;

  /// Campo de tiempo de recarga.
  ///
  /// In es, this message translates to:
  /// **'Tiempo de recarga'**
  String get rechargeTime;

  /// Campo de maximo acumulable.
  ///
  /// In es, this message translates to:
  /// **'Maximo acumulable'**
  String get maxAccumulated;

  /// Campo de coste de aceleracion completa.
  ///
  /// In es, this message translates to:
  /// **'Coste de aceleracion'**
  String get accelerationCost;

  /// Selector de diseno frontal de sobre.
  ///
  /// In es, this message translates to:
  /// **'Portada'**
  String get frontDesign;

  /// Selector de diseno trasero de sobre.
  ///
  /// In es, this message translates to:
  /// **'Reverso'**
  String get backDesign;

  /// Contador de cartas elegibles.
  ///
  /// In es, this message translates to:
  /// **'Cartas elegibles: {count}'**
  String eligibleCardsCount(int count);

  /// Campo de busqueda de cartas.
  ///
  /// In es, this message translates to:
  /// **'Buscar cartas'**
  String get searchCards;

  /// Filtro para todas las cartas.
  ///
  /// In es, this message translates to:
  /// **'Todas las cartas'**
  String get allCards;

  /// Accion para seleccionar todas las cartas.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar todas'**
  String get selectAll;

  /// Accion para deseleccionar todas las cartas.
  ///
  /// In es, this message translates to:
  /// **'Deseleccionar todas'**
  String get deselectAll;

  /// Seccion de reglas de posicion del sobre.
  ///
  /// In es, this message translates to:
  /// **'Reglas por posicion'**
  String get slotRules;

  /// Etiqueta de posicion del sobre.
  ///
  /// In es, this message translates to:
  /// **'Posicion {index}'**
  String slotPosition(int index);

  /// Tipo de regla de rareza fija.
  ///
  /// In es, this message translates to:
  /// **'Rareza fija'**
  String get fixedRarity;

  /// Tipo de regla de distribucion por probabilidades.
  ///
  /// In es, this message translates to:
  /// **'Distribucion'**
  String get probabilityDistribution;

  /// Tipo de regla de rareza minima.
  ///
  /// In es, this message translates to:
  /// **'Rareza minima'**
  String get minimumRarity;

  /// Seccion de validacion.
  ///
  /// In es, this message translates to:
  /// **'Validacion'**
  String get validation;

  /// Estado de sobre valido.
  ///
  /// In es, this message translates to:
  /// **'Configuracion valida'**
  String get packConfigurationValid;

  /// Estado de sobre incompleto.
  ///
  /// In es, this message translates to:
  /// **'Configuracion incompleta'**
  String get packConfigurationIncomplete;

  /// Error de sobre sin cartas elegibles.
  ///
  /// In es, this message translates to:
  /// **'No hay cartas elegibles'**
  String get noEligibleCards;

  /// Error de acumulacion minima del sobre principal.
  ///
  /// In es, this message translates to:
  /// **'El principal debe acumular al menos tres'**
  String get mainPackNeedsThree;

  /// Error de distribucion sin pesos positivos.
  ///
  /// In es, this message translates to:
  /// **'Cada distribucion necesita algun peso positivo'**
  String get probabilityNeedsWeight;

  /// Error de nombre obligatorio de sobre.
  ///
  /// In es, this message translates to:
  /// **'Escribe un nombre para el sobre'**
  String get packNameRequired;

  /// Error de nombre duplicado de sobre.
  ///
  /// In es, this message translates to:
  /// **'Ya existe un sobre con ese nombre'**
  String get duplicatePackName;

  /// Seccion de simulacion de sobres.
  ///
  /// In es, this message translates to:
  /// **'Simulacion'**
  String get simulation;

  /// Accion para simular aperturas.
  ///
  /// In es, this message translates to:
  /// **'Simular'**
  String get simulate;

  /// Mensaje de simulacion para sobres nuevos.
  ///
  /// In es, this message translates to:
  /// **'Guarda el sobre antes de simular'**
  String get savePackBeforeSimulating;

  /// Nombre provisional mostrado en previsualizacion de sobre.
  ///
  /// In es, this message translates to:
  /// **'Sobre'**
  String get packPreviewName;

  /// Requisito para poder revisar la coleccion.
  ///
  /// In es, this message translates to:
  /// **'Completa informacion, rarezas, cartas y sobres'**
  String get reviewNeedsCompleteDraft;

  /// Descripcion de la revision de finalizacion.
  ///
  /// In es, this message translates to:
  /// **'Comprueba que la coleccion esta lista antes de instalarla localmente.'**
  String get finalizationReviewDescription;

  /// Estado listo para finalizar.
  ///
  /// In es, this message translates to:
  /// **'Listo'**
  String get ready;

  /// Accion para finalizar un borrador.
  ///
  /// In es, this message translates to:
  /// **'Finalizar coleccion'**
  String get finalizeCollection;

  /// Confirmacion antes de finalizar coleccion.
  ///
  /// In es, this message translates to:
  /// **'Se instalara una copia local de esta coleccion y el borrador quedara solo lectura.'**
  String get finalizeCollectionDialogDescription;

  /// Confirmacion de finalizacion correcta.
  ///
  /// In es, this message translates to:
  /// **'Coleccion finalizada'**
  String get collectionFinalized;

  /// Error al finalizar coleccion.
  ///
  /// In es, this message translates to:
  /// **'No se ha podido finalizar la coleccion'**
  String get finalizeCollectionError;

  /// Titulo generico de detalle de coleccion instalada.
  ///
  /// In es, this message translates to:
  /// **'Coleccion instalada'**
  String get installedCollection;

  /// Progreso de cartas de una coleccion instalada.
  ///
  /// In es, this message translates to:
  /// **'{owned}/{total} cartas descubiertas'**
  String collectionProgress(int owned, int total);

  /// Titulo del inventario de sobres.
  ///
  /// In es, this message translates to:
  /// **'Sobres disponibles'**
  String get packInventory;

  /// Titulo de estado vacio de inventario de sobres.
  ///
  /// In es, this message translates to:
  /// **'No hay sobres instalados'**
  String get noPackInventoryTitle;

  /// Descripcion de estado vacio de inventario de sobres.
  ///
  /// In es, this message translates to:
  /// **'Esta coleccion no tiene tipos de sobre preparados.'**
  String get noPackInventoryDescription;

  /// Cantidad de sobres disponibles.
  ///
  /// In es, this message translates to:
  /// **'{available}/{max} disponibles'**
  String availablePacks(int available, int max);

  /// Tiempo restante hasta el siguiente sobre.
  ///
  /// In es, this message translates to:
  /// **'Siguiente sobre en {time}'**
  String nextPackIn(String time);

  /// Estado de inventario de sobre completo.
  ///
  /// In es, this message translates to:
  /// **'Acumulacion completa'**
  String get packRechargeFull;

  /// Estado de temporizador pausado por inventario en el maximo o por encima.
  ///
  /// In es, this message translates to:
  /// **'Recarga pausada hasta bajar de {max} sobres'**
  String packRechargePaused(int max);

  /// Boton deshabilitado de apertura futura.
  ///
  /// In es, this message translates to:
  /// **'Abrir sobre proximamente'**
  String get openPackComingSoon;

  /// Accion para abrir un sobre.
  ///
  /// In es, this message translates to:
  /// **'Abrir sobre'**
  String get openPack;

  /// Accion para abrir varios sobres de golpe.
  ///
  /// In es, this message translates to:
  /// **'Abrir x{count}'**
  String openPackBatch(int count);

  /// Titulo de apertura pendiente.
  ///
  /// In es, this message translates to:
  /// **'Apertura pendiente'**
  String get pendingOpening;

  /// Descripcion de recuperacion de apertura.
  ///
  /// In es, this message translates to:
  /// **'Continua la apertura guardada sin consumir otro sobre.'**
  String get pendingOpeningDescription;

  /// Accion para continuar una apertura pendiente.
  ///
  /// In es, this message translates to:
  /// **'Continuar apertura'**
  String get continueOpening;

  /// Seccion de album.
  ///
  /// In es, this message translates to:
  /// **'Album'**
  String get album;

  /// Filtro de todas las cartas.
  ///
  /// In es, this message translates to:
  /// **'Todas'**
  String get all;

  /// Filtro de cartas obtenidas.
  ///
  /// In es, this message translates to:
  /// **'Obtenidas'**
  String get owned;

  /// Filtro de cartas faltantes.
  ///
  /// In es, this message translates to:
  /// **'Faltantes'**
  String get missing;

  /// Filtro de cartas favoritas.
  ///
  /// In es, this message translates to:
  /// **'Favoritas'**
  String get favorites;

  /// Filtro de cartas repetidas.
  ///
  /// In es, this message translates to:
  /// **'Repetidas'**
  String get repeated;

  /// Filtro de todas las rarezas.
  ///
  /// In es, this message translates to:
  /// **'Todas las rarezas'**
  String get allRarities;

  /// Filtro de todos los tipos de medio.
  ///
  /// In es, this message translates to:
  /// **'Todos los medios'**
  String get allMedia;

  /// Tipo de medio video.
  ///
  /// In es, this message translates to:
  /// **'Video'**
  String get video;

  /// Seccion de seleccion de foto o video.
  ///
  /// In es, this message translates to:
  /// **'Contenido de la carta'**
  String get cardContent;

  /// Accion para seleccionar un video.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar video'**
  String get selectVideo;

  /// Accion para reemplazar un video.
  ///
  /// In es, this message translates to:
  /// **'Cambiar video'**
  String get changeVideo;

  /// Estado mientras se procesa un video.
  ///
  /// In es, this message translates to:
  /// **'Procesando video'**
  String get processingVideo;

  /// Error de video obligatorio.
  ///
  /// In es, this message translates to:
  /// **'El video es obligatorio'**
  String get videoRequired;

  /// Titulo del dialogo para elegir el tramo de video.
  ///
  /// In es, this message translates to:
  /// **'Recortar video'**
  String get trimVideoTitle;

  /// Descripcion del selector de tramo de video.
  ///
  /// In es, this message translates to:
  /// **'Elige que 15 segundos se usaran en la carta.'**
  String get trimVideoDescription;

  /// Rango temporal elegido del video.
  ///
  /// In es, this message translates to:
  /// **'Tramo: {start} - {end}'**
  String trimVideoRange(String start, String end);

  /// Accion para aceptar el tramo de video elegido.
  ///
  /// In es, this message translates to:
  /// **'Usar tramo'**
  String get useVideoClip;

  /// Duracion de un video.
  ///
  /// In es, this message translates to:
  /// **'Duracion: {value}'**
  String duration(String value);

  /// Accion para pausar video.
  ///
  /// In es, this message translates to:
  /// **'Pausar'**
  String get pause;

  /// Accion para repetir video.
  ///
  /// In es, this message translates to:
  /// **'Repetir'**
  String get replay;

  /// Error seguro de reproduccion de video.
  ///
  /// In es, this message translates to:
  /// **'No se ha podido reproducir el video.'**
  String get videoPlaybackFailed;

  /// Orden por primera obtencion.
  ///
  /// In es, this message translates to:
  /// **'Primera obtencion'**
  String get firstObtainedSort;

  /// Accion para marcar o desmarcar favorita.
  ///
  /// In es, this message translates to:
  /// **'Marcar favorita'**
  String get favoriteToggle;

  /// Orden por cantidad.
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get quantity;

  /// Carta no obtenida.
  ///
  /// In es, this message translates to:
  /// **'Sin descubrir'**
  String get undiscovered;

  /// Progreso del album.
  ///
  /// In es, this message translates to:
  /// **'{owned}/{total} cartas · {percent} %'**
  String albumProgress(int owned, int total, String percent);

  /// Total de copias en album.
  ///
  /// In es, this message translates to:
  /// **'Copias totales: {count}'**
  String totalCopies(int count);

  /// Total de favoritas.
  ///
  /// In es, this message translates to:
  /// **'Favoritas: {count}'**
  String favoriteCount(int count);

  /// Titulo de detalle de carta.
  ///
  /// In es, this message translates to:
  /// **'Detalle de carta'**
  String get cardDetail;

  /// Descripcion de carta faltante.
  ///
  /// In es, this message translates to:
  /// **'Todavia no has descubierto esta carta.'**
  String get cardStillMissing;

  /// Fecha de primera obtencion.
  ///
  /// In es, this message translates to:
  /// **'Primera obtencion: {date}'**
  String firstObtained(String date);

  /// Etiqueta de copias.
  ///
  /// In es, this message translates to:
  /// **'Copias'**
  String get copies;

  /// Accion para saltar animacion.
  ///
  /// In es, this message translates to:
  /// **'Saltar'**
  String get skip;

  /// Posicion de carta en apertura.
  ///
  /// In es, this message translates to:
  /// **'Carta {index} de {total}'**
  String cardPosition(int index, int total);

  /// Indicador de carta nueva.
  ///
  /// In es, this message translates to:
  /// **'Nueva'**
  String get newCard;

  /// Indicador de carta repetida.
  ///
  /// In es, this message translates to:
  /// **'Repetida · x{quantity}'**
  String repeatedCard(int quantity);

  /// Accion para avanzar.
  ///
  /// In es, this message translates to:
  /// **'Siguiente'**
  String get next;

  /// Accion para revelar carta.
  ///
  /// In es, this message translates to:
  /// **'Revelar carta'**
  String get revealCard;

  /// Titulo del resumen de apertura.
  ///
  /// In es, this message translates to:
  /// **'Resumen'**
  String get summary;

  /// Conteos de resumen de apertura.
  ///
  /// In es, this message translates to:
  /// **'Nuevas: {newCount} · Repetidas: {repeatedCount}'**
  String openingSummaryCounts(int newCount, int repeatedCount);

  /// Accion para ver album.
  ///
  /// In es, this message translates to:
  /// **'Ver album'**
  String get viewAlbum;

  /// Accion para volver a sobres.
  ///
  /// In es, this message translates to:
  /// **'Volver a sobres'**
  String get backToPacks;

  /// Accion para importar una coleccion.
  ///
  /// In es, this message translates to:
  /// **'Importar coleccion'**
  String get importCollection;

  /// Accion para exportar una coleccion.
  ///
  /// In es, this message translates to:
  /// **'Exportar coleccion'**
  String get exportCollection;

  /// Titulo del dialogo de previsualizacion de importacion.
  ///
  /// In es, this message translates to:
  /// **'Importar paquete .gachadex'**
  String get importPreviewTitle;

  /// Resumen antes de confirmar una importacion.
  ///
  /// In es, this message translates to:
  /// **'{name}\nCartas: {cardCount}\nVideos: {videoCount}\nSobres: {packTypeCount}\n\nSolo se importara la definicion de la coleccion. El progreso, gachacoin y album empezaran desde cero.'**
  String importPreviewDescription(
    String name,
    int cardCount,
    int videoCount,
    int packTypeCount,
  );

  /// Confirmacion de importacion.
  ///
  /// In es, this message translates to:
  /// **'Coleccion importada.'**
  String get collectionImported;

  /// Confirmacion de exportacion.
  ///
  /// In es, this message translates to:
  /// **'Paquete .gachadex preparado.'**
  String get collectionExported;

  /// Mensaje para coleccion ya instalada.
  ///
  /// In es, this message translates to:
  /// **'Esta coleccion ya esta instalada.'**
  String get collectionAlreadyInstalled;

  /// Error generico de importacion.
  ///
  /// In es, this message translates to:
  /// **'No se pudo importar el paquete .gachadex.'**
  String get importError;

  /// Error generico de exportacion.
  ///
  /// In es, this message translates to:
  /// **'No se pudo exportar la coleccion.'**
  String get exportError;

  /// Nombre visible de la moneda local.
  ///
  /// In es, this message translates to:
  /// **'gachacoin'**
  String get gachacoin;

  /// Saldo de gachacoin.
  ///
  /// In es, this message translates to:
  /// **'{amount} gachacoin'**
  String gachacoinBalance(int amount);

  /// Titulo del historial de movimientos.
  ///
  /// In es, this message translates to:
  /// **'Movimientos'**
  String get movements;

  /// Accion para vender cartas repetidas.
  ///
  /// In es, this message translates to:
  /// **'Vender repetidas'**
  String get sellDuplicates;

  /// Cantidad de copias vendibles.
  ///
  /// In es, this message translates to:
  /// **'Copias vendibles: {count}'**
  String sellableCopies(int count);

  /// Etiqueta de cantidad a vender.
  ///
  /// In es, this message translates to:
  /// **'Cantidad a vender'**
  String get quantityToSell;

  /// Ingreso esperado por una venta.
  ///
  /// In es, this message translates to:
  /// **'Recibiras {amount} gachacoin'**
  String youWillReceive(int amount);

  /// Accion para confirmar una venta.
  ///
  /// In es, this message translates to:
  /// **'Confirmar venta'**
  String get confirmSale;

  /// Confirmacion de venta.
  ///
  /// In es, this message translates to:
  /// **'Venta realizada.'**
  String get saleCompleted;

  /// Accion para acelerar temporizador.
  ///
  /// In es, this message translates to:
  /// **'Acelerar'**
  String get speedUp;

  /// Titulo de aceleracion de temporizador.
  ///
  /// In es, this message translates to:
  /// **'Completar temporizador'**
  String get completeTimer;

  /// Opcion de aceleracion singular.
  ///
  /// In es, this message translates to:
  /// **'+{count} sobre'**
  String addPackOption(int count);

  /// Opcion de aceleracion plural.
  ///
  /// In es, this message translates to:
  /// **'+{count} sobres'**
  String addPacksOption(int count);

  /// Etiqueta de coste.
  ///
  /// In es, this message translates to:
  /// **'Coste'**
  String get cost;

  /// Saldo despues de una operacion.
  ///
  /// In es, this message translates to:
  /// **'Saldo despues: {amount} gachacoin'**
  String balanceAfter(int amount);

  /// Error de saldo insuficiente.
  ///
  /// In es, this message translates to:
  /// **'No tienes suficientes gachacoin.'**
  String get notEnoughGachacoin;

  /// Mensaje de inventario lleno.
  ///
  /// In es, this message translates to:
  /// **'Maximo de sobres alcanzado.'**
  String get maxPacksReached;

  /// Movimiento de venta.
  ///
  /// In es, this message translates to:
  /// **'Venta de repetida'**
  String get duplicateSaleMovement;

  /// Movimiento de aceleracion.
  ///
  /// In es, this message translates to:
  /// **'Aceleracion de sobre'**
  String get packAccelerationMovement;

  /// Valor unitario de venta.
  ///
  /// In es, this message translates to:
  /// **'Valor unitario: {amount} gachacoin'**
  String unitSellValue(int amount);

  /// Calculo de venta.
  ///
  /// In es, this message translates to:
  /// **'{quantity} x {value} = {amount} gachacoin'**
  String saleIncomePreview(int quantity, int value, int amount);

  /// Saldo tras movimiento.
  ///
  /// In es, this message translates to:
  /// **'Saldo: {amount}'**
  String transactionBalanceAfter(int amount);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
