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
