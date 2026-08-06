// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Gachadex';

  @override
  String get home => 'Inicio';

  @override
  String get collections => 'Colecciones';

  @override
  String get create => 'Crear';

  @override
  String get settings => 'Ajustes';

  @override
  String get theme => 'Tema';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get retry => 'Reintentar';

  @override
  String get screenErrorTitle => 'No se ha podido mostrar esta pantalla.';

  @override
  String get noCollections => 'Todavía no hay colecciones.';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get homePackMessage => 'Aquí aparecerán los sobres disponibles.';

  @override
  String get collectionsEmptyDescription =>
      'Aquí aparecerán las colecciones instaladas y los proyectos creados.';

  @override
  String get createDescription =>
      'Aquí se crearán colecciones cuando la fase de creador esté lista.';

  @override
  String get controlledError => 'Error controlado';

  @override
  String get controlledErrorDescription =>
      'Esta pantalla comprueba que los errores se muestran con un mensaje seguro.';

  @override
  String get openControlledError => 'Ver error controlado';

  @override
  String get openControlledErrorTooltip =>
      'Abre la pantalla de error controlado';

  @override
  String get notFoundTitle => 'Página no encontrada';

  @override
  String get notFoundDescription => 'La ruta solicitada no existe en Gachadex.';

  @override
  String get loading => 'Cargando';

  @override
  String get appInfo => 'Información de la aplicación';

  @override
  String get phaseOneStatus => 'Fase 1: base técnica ejecutable.';

  @override
  String get themeSessionOnly =>
      'La preferencia de tema se mantiene durante la sesión. La persistencia llegará cuando exista infraestructura local.';

  @override
  String get createDisabledAction => 'Crear colección';

  @override
  String get collectionDraftsDescription =>
      'Prepara colecciones locales y retoma cualquier borrador sin perder cambios.';

  @override
  String get newCollection => 'Nueva colección';

  @override
  String get createCollection => 'Crear colección';

  @override
  String get unnamedCollection => 'Colección sin nombre';

  @override
  String get draft => 'Borrador';

  @override
  String get information => 'Información';

  @override
  String get rarities => 'Rarezas';

  @override
  String get cards => 'Cartas';

  @override
  String get packs => 'Sobres';

  @override
  String get review => 'Revisión';

  @override
  String get name => 'Nombre';

  @override
  String get collectionName => 'Nombre de colección';

  @override
  String get author => 'Autor';

  @override
  String get description => 'Descripción';

  @override
  String get cover => 'Portada';

  @override
  String get savePending => 'Cambios pendientes';

  @override
  String get saving => 'Guardando...';

  @override
  String get saved => 'Guardado';

  @override
  String get saveError => 'No se han podido guardar los cambios';

  @override
  String get fixFieldsToSave => 'Corrige los campos para guardar';

  @override
  String get addRarity => 'Añadir rareza';

  @override
  String get editRarity => 'Editar rareza';

  @override
  String get deleteRarity => 'Eliminar rareza';

  @override
  String get sellValue => 'Valor de venta';

  @override
  String get color => 'Color';

  @override
  String get primaryColor => 'Color principal';

  @override
  String get accentColor => 'Color secundario';

  @override
  String get icon => 'Icono';

  @override
  String get frame => 'Marco';

  @override
  String get effect => 'Efecto';

  @override
  String get style => 'Estilo';

  @override
  String get order => 'Orden';

  @override
  String get moveUp => 'Subir';

  @override
  String get moveDown => 'Bajar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteDraft => 'Eliminar borrador';

  @override
  String get emptyDraftsTitle => 'Todavía no has creado ninguna colección';

  @override
  String get emptyDraftsDescription =>
      'Crea un borrador para empezar a preparar tus cartas y rarezas.';

  @override
  String get continueEditing => 'Continuar';

  @override
  String rarityCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rarezas',
      one: '1 rareza',
      zero: 'Sin rarezas',
    );
    return '$_temp0';
  }

  @override
  String lastUpdated(String date) {
    return 'Última edición: $date';
  }

  @override
  String get incompleteDraft => 'Borrador incompleto';

  @override
  String get completeForThisPhase => 'Completo para esta fase';

  @override
  String get notStarted => 'No iniciado';

  @override
  String get incomplete => 'Incompleto';

  @override
  String get withErrors => 'Con errores';

  @override
  String get pending => 'Pendiente';

  @override
  String get collectionNeedsName => 'La colección necesita un nombre';

  @override
  String get atLeastOneRarity => 'Debe existir al menos una rareza';

  @override
  String get availableLater => 'Disponible más adelante';

  @override
  String get projectNotFound => 'No se ha encontrado este borrador.';

  @override
  String get backToDrafts => 'Volver a borradores';

  @override
  String get deleteDraftDialogTitle => 'Eliminar borrador';

  @override
  String get deleteDraftDialogDescription =>
      'Se eliminará este borrador y toda su configuración local. Esta acción no se puede deshacer.';

  @override
  String get draftDeleted => 'Borrador eliminado';

  @override
  String get deleteRarityDialogTitle => 'Eliminar rareza';

  @override
  String get deleteRarityDialogDescription =>
      'No podrás recuperar esta rareza después de eliminarla.';

  @override
  String get rarityInUse =>
      'No puedes eliminar esta rareza porque está asignada a una o más cartas.';

  @override
  String get rarityDeleted => 'Rareza eliminada';

  @override
  String get raritySaved => 'Rareza guardada';

  @override
  String get noRaritiesTitle => 'Todavía no hay rarezas';

  @override
  String get noRaritiesDescription =>
      'Añade al menos una rareza para completar esta parte del borrador.';

  @override
  String get fieldTooLong => 'Has superado el máximo permitido';

  @override
  String get rarityNameRequired => 'Escribe un nombre para la rareza';

  @override
  String get duplicateRarityName => 'Ya existe una rareza con ese nombre';

  @override
  String get sellValueInvalid => 'Introduce un valor entre 0 y 999999';

  @override
  String get invalidVisualOption => 'Elige una opción del catálogo';

  @override
  String charactersCounter(int count, int max) {
    return '$count/$max';
  }

  @override
  String get enabled => 'Activa';

  @override
  String get disabled => 'Desactivada';

  @override
  String get coverColorTeal => 'Verde agua';

  @override
  String get coverColorCoral => 'Coral';

  @override
  String get coverColorGold => 'Dorado';

  @override
  String get coverColorLilac => 'Lila';

  @override
  String get coverColorSky => 'Azul cielo';

  @override
  String get coverColorMint => 'Menta';

  @override
  String get coverColorRose => 'Rosa';

  @override
  String get coverColorGraphite => 'Grafito';

  @override
  String get coverIconSpark => 'Destello';

  @override
  String get coverIconCards => 'Cartas';

  @override
  String get coverIconLaugh => 'Risa';

  @override
  String get coverIconCamera => 'Cámara';

  @override
  String get coverIconGroup => 'Grupo';

  @override
  String get coverIconTrophy => 'Trofeo';

  @override
  String get coverPatternSolid => 'Liso';

  @override
  String get coverPatternDiagonal => 'Diagonal';

  @override
  String get coverPatternDots => 'Puntos';

  @override
  String get coverPatternSplit => 'Bicolor';

  @override
  String get rarityColorGray => 'Gris';

  @override
  String get rarityColorGreen => 'Verde';

  @override
  String get rarityColorBlue => 'Azul';

  @override
  String get rarityColorPurple => 'Morado';

  @override
  String get rarityColorRed => 'Rojo';

  @override
  String get rarityColorOrange => 'Naranja';

  @override
  String get rarityColorPink => 'Rosa';

  @override
  String get rarityColorGold => 'Dorado';

  @override
  String get rarityColorTurquoise => 'Turquesa';

  @override
  String get rarityColorGraphite => 'Grafito';

  @override
  String get rarityIconStar => 'Estrella';

  @override
  String get rarityIconCrown => 'Corona';

  @override
  String get rarityIconDiamond => 'Diamante';

  @override
  String get rarityIconFire => 'Fuego';

  @override
  String get rarityIconBolt => 'Rayo';

  @override
  String get rarityIconRocket => 'Cohete';

  @override
  String get rarityIconGlasses => 'Gafas';

  @override
  String get rarityIconTrophy => 'Trofeo';

  @override
  String get rarityIconGhost => 'Fantasma';

  @override
  String get rarityIconFootprint => 'Huella';

  @override
  String get rarityIconSmile => 'Sonrisa';

  @override
  String get rarityIconBurst => 'Explosión';

  @override
  String get rarityIconHeart => 'Corazón';

  @override
  String get rarityIconMoon => 'Luna';

  @override
  String get rarityIconSun => 'Sol';

  @override
  String get rarityFrameSimple => 'Simple';

  @override
  String get rarityFrameRounded => 'Redondeado';

  @override
  String get rarityFrameDouble => 'Doble línea';

  @override
  String get rarityFrameMetallic => 'Metálico';

  @override
  String get rarityFrameNeon => 'Neón';

  @override
  String get rarityFrameComic => 'Cómico';

  @override
  String get rarityFrameElegant => 'Elegante';

  @override
  String get rarityFramePixel => 'Pixelado';

  @override
  String get rarityEffectNone => 'Ninguno';

  @override
  String get rarityEffectSoftGlow => 'Brillo suave';

  @override
  String get rarityEffectSpark => 'Destello';

  @override
  String get rarityEffectGradient => 'Gradiente';

  @override
  String get rarityEffectHolo => 'Holográfico simulado';

  @override
  String get rarityEffectPulse => 'Pulso';

  @override
  String get addCard => 'AÃ±adir carta';

  @override
  String get editCard => 'Editar carta';

  @override
  String get deleteCard => 'Eliminar carta';

  @override
  String get selectPhoto => 'Seleccionar fotografÃ­a';

  @override
  String get changePhoto => 'Cambiar fotografÃ­a';

  @override
  String get photo => 'FotografÃ­a';

  @override
  String get processingImage => 'Procesando imagen...';

  @override
  String get photoRequired => 'La fotografÃ­a es obligatoria';

  @override
  String get mainData => 'Datos principales';

  @override
  String get health => 'Vida';

  @override
  String get collectionNumber => 'NÃºmero';

  @override
  String get rarity => 'Rareza';

  @override
  String get template => 'Plantilla';

  @override
  String get appearance => 'Apariencia';

  @override
  String get comicFields => 'Campos cÃ³micos';

  @override
  String get addComicField => 'AÃ±adir campo';

  @override
  String get value => 'Valor';

  @override
  String get preview => 'PrevisualizaciÃ³n';

  @override
  String get cardNameRequired => 'Escribe un nombre para la carta';

  @override
  String get healthInvalid => 'Introduce una vida entre 1 y 9999';

  @override
  String get collectionNumberInvalid => 'Introduce un nÃºmero positivo';

  @override
  String get collectionNumberUsed => 'Ese nÃºmero ya estÃ¡ utilizado';

  @override
  String get rarityRequired => 'Elige una rareza';

  @override
  String get cardInvalid => 'Corrige la carta antes de guardarla';

  @override
  String get cardDeleted => 'Carta eliminada';

  @override
  String get deleteCardDialogDescription =>
      'Se eliminarÃ¡ esta carta y su fotografÃ­a. Esta acciÃ³n no se puede deshacer.';

  @override
  String get unsavedChanges => 'Cambios sin guardar';

  @override
  String get discardChanges => 'Descartar cambios';

  @override
  String get discardChangesQuestion =>
      'Hay cambios sin guardar. Â¿Quieres descartarlos?';

  @override
  String get noCardsTitle => 'TodavÃ­a no hay cartas';

  @override
  String get noCardsDescription => 'Crea la primera carta de esta colecciÃ³n.';

  @override
  String get atLeastOneCard => 'Debe existir al menos una carta';

  @override
  String get backToDraft => 'Volver al borrador';
}
