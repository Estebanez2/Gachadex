abstract final class AppRoutes {
  static const rootPath = '/';

  static const homeName = 'home';
  static const homePath = '/home';

  static const collectionsName = 'collections';
  static const collectionsPath = '/collections';

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

  static const settingsName = 'settings';
  static const settingsPath = '/settings';

  static const controlledErrorName = 'controlled-error';
  static const controlledErrorPath = '/controlled-error';
}
