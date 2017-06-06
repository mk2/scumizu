module.exports = {
  /**
   * Application configuration section
   * http://pm2.keymetrics.io/docs/usage/application-declaration/
   */
  apps : [

    // Scumizu applicatoin
    {
      name        : 'scumizu',
      script      : 'app.js',
      watch       : ["api", "assets"],
      ignore_watch: ["node_modules", ".tmp", "views"],
      env: {
      },
      env_production : {
        NODE_ENV: 'production'
      }
    }
  ]
};
