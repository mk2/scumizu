/**
 * Route Mappings
 * (sails.config.routes)
 *
 * Your routes tell Sails what to do each time it receives a request.
 *
 * For more information on configuring custom routes, check out:
 * https://sailsjs.com/anatomy/config/routes-js
 */

module.exports.routes = {


  /***************************************************************************
  *                                                                          *
  * Make the view located at `views/homepage.ejs` your home page.            *
  *                                                                          *
  * (Alternatively, remove this and add an `index.html` file in your         *
  * `assets` directory)                                                      *
  *                                                                          *
  ***************************************************************************/

  'GET /': 'PageController.index',

  'GET /backlog': 'PageController.backlog',

  'GET /sprints':           'PageController.sprints',
  'GET /sprint/create':     'PageController.sprintCreate',
  'GET /sprint/update/:id': 'PageController.sprintUpdate',

  'GET /login':  'PageController.login',
  'GET /signup': 'PageController.signup',
  'GET /logout': 'PageController.logout',

  /***************************************************************************
  *                                                                          *
  * Custom routes here...                                                    *
  *                                                                          *
  * If a request to a URL doesn't match any of the custom routes above, it   *
  * is matched against Sails route blueprints. See `config/blueprints.js`    *
  * for configuration options and examples.                                  *
  *                                                                          *
  ***************************************************************************/

  'POST /api/login':  'UserController.login',
  'POST /api/signup': 'UserController.signup',
  'GET  /api/logout': 'UserController.logout',

  'POST /api/sprint/create':     'SprintController.create',
  'POST /api/sprint/update/:id': 'SprintController.update',
  'POST /api/sprint/delete/:id': 'SprintController.delete',

  'GET  /api/task/current':    'TaskController.getCurrentSprintTasks',
  'POST /api/task/create':     'TaskController.create',
  'POST /api/task/update/:id': 'TaskController.update',
  'POST /api/task/delete/:id': 'TaskController.delete',
};
