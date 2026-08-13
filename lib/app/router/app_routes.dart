abstract final class AppRoutes {
  static const rootPath = '/';

  static const homeName = 'home';
  static const homePath = '/home';

  static const albumName = 'album';
  static const albumPath = '/album';

  static const collectionsName = 'collections';
  static const collectionsPath = '/collections';
  static const installedCollectionName = 'installed-collection';
  static const installedCollectionPathPrefix = '/album';
  static String installedCollectionPath(String installedCollectionId) {
    return '$installedCollectionPathPrefix/$installedCollectionId';
  }

  static String installedCollectionAlbumPath(String installedCollectionId) {
    return '${installedCollectionPath(installedCollectionId)}?tab=album';
  }

  static const packOpeningName = 'pack-opening';
  static String packOpeningPath(
    String installedCollectionId,
    String openingId,
  ) {
    return '${installedCollectionPath(installedCollectionId)}/openings/$openingId';
  }

  static const albumCardName = 'album-card';
  static String albumCardPath(String installedCollectionId, String cardId) {
    return '${installedCollectionPath(installedCollectionId)}/cards/$cardId';
  }

  static const createName = 'create';
  static const createPath = '/create';
  static const createNewName = 'create-new';
  static const createNewPath = '/create/new';
  static const createProjectName = 'create-project';
  static const createProjectPathPrefix = '/create/project';
  static String createProjectPath(String projectId) {
    return '$createProjectPathPrefix/$projectId';
  }

  static const createCardNewName = 'create-card-new';
  static String createCardNewPath(String projectId) {
    return '${createProjectPath(projectId)}/cards/new';
  }

  static const createCardEditName = 'create-card-edit';
  static String createCardEditPath(String projectId, String cardId) {
    return '${createProjectPath(projectId)}/cards/$cardId';
  }

  static const createPackNewName = 'create-pack-new';
  static String createPackNewPath(String projectId) {
    return '${createProjectPath(projectId)}/packs/new';
  }

  static const createPackEditName = 'create-pack-edit';
  static String createPackEditPath(String projectId, String packTypeId) {
    return '${createProjectPath(projectId)}/packs/$packTypeId';
  }

  static const settingsName = 'settings';
  static const settingsPath = '/settings';
}
