/**
 * Bootstrap
 * (sails.config.bootstrap)
 *
 * An asynchronous bootstrap function that runs before your Sails app gets lifted.
 * This gives you an opportunity to set up your data model, run jobs, or perform some special logic.
 *
 * For more information on bootstrapping your app, check out:
 * https://sailsjs.com/config/bootstrap
 */

module.exports.bootstrap = function(done) {

  sails.log('!!! Start Scumizu bootstrap...');

  // set moment to sails.moment for global access
  sails.moment = require('moment');

  // setup backlog sprint
  Sprint.create({
    name:     'backlog',
    startDate: 0,
    endDate:   0,
    memo:     'not editable',
    isLocked:  true,
    isHidden:  true,
  }).then(() => {
    sails.log('backlog sprint was created!');

    // 開発環境ではテスト用ユーザーを追加する
    // TODO バックログ用のルートタスクを追加
    if (sails.config.environment === 'development' ||
        sails.config.environment === 'test') {
      const brcypt   = require('bcryptjs'),
            name     = 'scumizu master',
            password = 'ilovescumizu',
            email    = 'scumizu';

      brcypt.hash(password, sails.config.auth.saltRounds, (err, hash) => {
        User.create({
          name,
          password: hash,
          email,
        }).then(() => {
          sails.log('Default user created!');
          done();
        }).catch(err => {
          sails.log('No dummy user.');
          done();
        });
      });
    }
  });
};
