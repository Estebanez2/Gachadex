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
  String get albumEmptyTitle => 'Aun no tienes ninguna coleccion.';

  @override
  String get albumEmptyDescription =>
      'Crea una coleccion o importa un paquete .gachadex para empezar.';

  @override
  String get albumLibraryDescription =>
      'Tus colecciones instaladas y jugables aparecen aqui.';

  @override
  String get availablePacksTitle => 'Sobres disponibles';

  @override
  String homeAvailablePacksCount(int count) {
    return 'Tienes $count sobres disponibles';
  }

  @override
  String get noAvailablePacks => 'No tienes sobres disponibles';

  @override
  String get homeEmptyDescription =>
      'Importa una coleccion o vuelve mas tarde cuando se recarguen tus sobres.';

  @override
  String homePackAvailableLine(int available, int max) {
    return '$available/$max disponibles';
  }

  @override
  String get available => 'Disponible';

  @override
  String totalAvailablePacksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sobres disponibles',
      one: '1 sobre disponible',
      zero: '0 sobres disponibles',
    );
    return '$_temp0';
  }

  @override
  String get viewCollection => 'Ver coleccion';

  @override
  String get collectionsEmptyDescription =>
      'Aquí aparecerán las colecciones instaladas y los proyectos creados.';

  @override
  String get createDescription =>
      'Aquí se crearán colecciones cuando la fase de creador esté lista.';

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
  String get packNotifications => 'Notificaciones de sobres';

  @override
  String get packNotificationsEnabledDescription =>
      'Te avisaremos cuando un sobre vuelva a estar disponible.';

  @override
  String get packNotificationsDisabledDescription =>
      'No se programaran avisos de recarga de sobres.';

  @override
  String get packNotificationsError =>
      'No se pudo leer la preferencia de notificaciones.';

  @override
  String get openNotificationSettings => 'Abrir ajustes de notificaciones';

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
  String get appearanceProbability => 'Probabilidad de aparicion';

  @override
  String get probabilityWeightInvalid => 'Introduce un valor entre 0 y 100';

  @override
  String rarityProbabilityTotal(int total) {
    return 'Probabilidad total: $total %';
  }

  @override
  String rarityProbabilityMissing(int missing) {
    return 'Falta $missing %';
  }

  @override
  String rarityProbabilityExcess(int excess) {
    return 'Sobran $excess %';
  }

  @override
  String get rarityProbabilityComplete => 'Distribucion lista';

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

  @override
  String get addPack => 'AÃ±adir sobre';

  @override
  String get editPack => 'Editar sobre';

  @override
  String get deletePack => 'Eliminar sobre';

  @override
  String get deletePackDescription =>
      'Se eliminarÃ¡ este sobre, sus cartas elegibles, reglas y probabilidades.';

  @override
  String get packDeleted => 'Sobre eliminado';

  @override
  String get packSaved => 'Sobre guardado';

  @override
  String get atLeastOnePack => 'Debe existir al menos un sobre';

  @override
  String get noPacksTitle => 'TodavÃ­a no hay sobres';

  @override
  String get noPacksDescription =>
      'Crea un sobre para configurar cartas elegibles y probabilidades.';

  @override
  String get mainPack => 'Sobre principal';

  @override
  String get packSecondary => 'Sobre secundario';

  @override
  String get cardsPerPack => 'Cartas por sobre';

  @override
  String get rechargeTime => 'Tiempo de recarga';

  @override
  String get maxAccumulated => 'Maximo acumulable';

  @override
  String get accelerationCost => 'Coste de aceleracion';

  @override
  String get frontDesign => 'Portada';

  @override
  String get backDesign => 'Reverso';

  @override
  String eligibleCardsCount(int count) {
    return 'Cartas elegibles: $count';
  }

  @override
  String get searchCards => 'Buscar cartas';

  @override
  String get allCards => 'Todas las cartas';

  @override
  String get selectAll => 'Seleccionar todas';

  @override
  String get deselectAll => 'Deseleccionar todas';

  @override
  String get slotRules => 'Reglas por posicion';

  @override
  String slotPosition(int index) {
    return 'Posicion $index';
  }

  @override
  String get fixedRarity => 'Rareza fija';

  @override
  String get probabilityDistribution => 'Distribucion';

  @override
  String get minimumRarity => 'Rareza minima';

  @override
  String get validation => 'Validacion';

  @override
  String get packConfigurationValid => 'Configuracion valida';

  @override
  String get packConfigurationIncomplete => 'Configuracion incompleta';

  @override
  String get noEligibleCards => 'No hay cartas elegibles';

  @override
  String get mainPackNeedsThree => 'El principal debe acumular al menos tres';

  @override
  String get probabilityNeedsWeight =>
      'Cada distribucion necesita algun peso positivo';

  @override
  String get collectionRarityProbabilities =>
      'Usa las probabilidades de la coleccion';

  @override
  String get packNameRequired => 'Escribe un nombre para el sobre';

  @override
  String get duplicatePackName => 'Ya existe un sobre con ese nombre';

  @override
  String get simulation => 'Simulacion';

  @override
  String get simulate => 'Simular';

  @override
  String get savePackBeforeSimulating => 'Guarda el sobre antes de simular';

  @override
  String get packPreviewName => 'Sobre';

  @override
  String get reviewNeedsCompleteDraft =>
      'Completa informacion, rarezas, cartas y sobres';

  @override
  String get finalizationReviewDescription =>
      'Comprueba que la coleccion esta lista antes de instalarla localmente.';

  @override
  String get ready => 'Listo';

  @override
  String get finalizeCollection => 'Finalizar coleccion';

  @override
  String get finalizeCollectionDialogDescription =>
      'Se instalara una copia local de esta coleccion y el borrador quedara solo lectura.';

  @override
  String get collectionFinalized => 'Coleccion finalizada';

  @override
  String get finalizeCollectionError =>
      'No se ha podido finalizar la coleccion';

  @override
  String get installedCollection => 'Coleccion instalada';

  @override
  String collectionProgress(int owned, int total) {
    return '$owned/$total cartas descubiertas';
  }

  @override
  String get packInventory => 'Sobres disponibles';

  @override
  String get noPackInventoryTitle => 'No hay sobres instalados';

  @override
  String get noPackInventoryDescription =>
      'Esta coleccion no tiene tipos de sobre preparados.';

  @override
  String availablePacks(int available, int max) {
    return '$available/$max disponibles';
  }

  @override
  String nextPackIn(String time) {
    return 'Siguiente sobre en $time';
  }

  @override
  String get packRechargeFull => 'Acumulacion completa';

  @override
  String packRechargePaused(int max) {
    return 'Recarga pausada hasta bajar de $max sobres';
  }

  @override
  String get openPackComingSoon => 'Abrir sobre proximamente';

  @override
  String get openPack => 'Abrir sobre';

  @override
  String openPackBatch(int count) {
    return 'Abrir x$count';
  }

  @override
  String get pendingOpening => 'Apertura pendiente';

  @override
  String get pendingOpeningDescription =>
      'Continua la apertura guardada sin consumir otro sobre.';

  @override
  String get continueOpening => 'Continuar apertura';

  @override
  String get album => 'Álbum';

  @override
  String get all => 'Todas';

  @override
  String get owned => 'Obtenidas';

  @override
  String get missing => 'Faltantes';

  @override
  String get favorites => 'Favoritas';

  @override
  String get repeated => 'Repetidas';

  @override
  String get allRarities => 'Todas las rarezas';

  @override
  String get allMedia => 'Todos los medios';

  @override
  String get video => 'Video';

  @override
  String get cardContent => 'Contenido de la carta';

  @override
  String get selectVideo => 'Seleccionar video';

  @override
  String get changeVideo => 'Cambiar video';

  @override
  String get processingVideo => 'Procesando video';

  @override
  String get videoRequired => 'El video es obligatorio';

  @override
  String get trimVideoTitle => 'Recortar video';

  @override
  String get trimVideoDescription =>
      'Elige que 15 segundos se usaran en la carta.';

  @override
  String trimVideoRange(String start, String end) {
    return 'Tramo: $start - $end';
  }

  @override
  String get useVideoClip => 'Usar tramo';

  @override
  String duration(String value) {
    return 'Duracion: $value';
  }

  @override
  String get pause => 'Pausar';

  @override
  String get replay => 'Repetir';

  @override
  String get videoPlaybackFailed => 'No se ha podido reproducir el video.';

  @override
  String get firstObtainedSort => 'Primera obtencion';

  @override
  String get favoriteToggle => 'Marcar favorita';

  @override
  String get quantity => 'Cantidad';

  @override
  String get undiscovered => 'Sin descubrir';

  @override
  String albumProgress(int owned, int total, String percent) {
    return '$owned/$total cartas · $percent %';
  }

  @override
  String totalCopies(int count) {
    return 'Copias totales: $count';
  }

  @override
  String favoriteCount(int count) {
    return 'Favoritas: $count';
  }

  @override
  String get cardDetail => 'Detalle de carta';

  @override
  String get cardStillMissing => 'Todavia no has descubierto esta carta.';

  @override
  String firstObtained(String date) {
    return 'Primera obtencion: $date';
  }

  @override
  String get copies => 'Copias';

  @override
  String get skip => 'Saltar';

  @override
  String cardPosition(int index, int total) {
    return 'Carta $index de $total';
  }

  @override
  String get newCard => 'Nueva';

  @override
  String repeatedCard(int quantity) {
    return 'Repetida · x$quantity';
  }

  @override
  String get next => 'Siguiente';

  @override
  String get revealCard => 'Revelar carta';

  @override
  String get summary => 'Resumen';

  @override
  String openingSummaryCounts(int newCount, int repeatedCount) {
    return 'Nuevas: $newCount · Repetidas: $repeatedCount';
  }

  @override
  String get viewAlbum => 'Ver cartas';

  @override
  String get backToPacks => 'Volver a sobres';

  @override
  String get importCollection => 'Importar coleccion';

  @override
  String get exportCollection => 'Exportar coleccion';

  @override
  String get importPreviewTitle => 'Importar paquete .gachadex';

  @override
  String importPreviewDescription(
    String name,
    int cardCount,
    int videoCount,
    int packTypeCount,
  ) {
    return '$name\nCartas: $cardCount\nVideos: $videoCount\nSobres: $packTypeCount\n\nSolo se importara la definicion de la coleccion. El progreso, gachacoin y album empezaran desde cero.';
  }

  @override
  String get collectionImported => 'Coleccion importada.';

  @override
  String get collectionExported => 'Paquete .gachadex preparado.';

  @override
  String get collectionAlreadyInstalled => 'Esta coleccion ya esta instalada.';

  @override
  String get importError => 'No se pudo importar el paquete .gachadex.';

  @override
  String get exportError => 'No se pudo exportar la coleccion.';

  @override
  String get gachacoin => 'gachacoin';

  @override
  String gachacoinBalance(int amount) {
    return '$amount gachacoin';
  }

  @override
  String get movements => 'Movimientos';

  @override
  String get noMovements => 'Aun no hay movimientos.';

  @override
  String get sellDuplicates => 'Vender repetidas';

  @override
  String sellableCopies(int count) {
    return 'Copias vendibles: $count';
  }

  @override
  String get quantityToSell => 'Cantidad a vender';

  @override
  String youWillReceive(int amount) {
    return 'Recibiras $amount gachacoin';
  }

  @override
  String get confirmSale => 'Confirmar venta';

  @override
  String get saleCompleted => 'Venta realizada.';

  @override
  String get speedUp => 'Acelerar';

  @override
  String get completeTimer => 'Completar temporizador';

  @override
  String addPackOption(int count) {
    return '+$count sobre';
  }

  @override
  String addPacksOption(int count) {
    return '+$count sobres';
  }

  @override
  String get cost => 'Coste';

  @override
  String balanceAfter(int amount) {
    return 'Saldo despues: $amount gachacoin';
  }

  @override
  String get notEnoughGachacoin => 'No tienes suficientes gachacoin.';

  @override
  String get maxPacksReached => 'Maximo de sobres alcanzado.';

  @override
  String get duplicateSaleMovement => 'Venta de repetida';

  @override
  String get packAccelerationMovement => 'Aceleracion de sobre';

  @override
  String unitSellValue(int amount) {
    return 'Valor unitario: $amount gachacoin';
  }

  @override
  String saleIncomePreview(int quantity, int value, int amount) {
    return '$quantity x $value = $amount gachacoin';
  }

  @override
  String transactionBalanceAfter(int amount) {
    return 'Saldo: $amount';
  }
}
