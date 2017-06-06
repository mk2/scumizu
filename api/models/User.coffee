 # User.coffee
 #
 # @description :: A model definition.  Represents a database table/collection/etc.
 # @docs        :: https://sailsjs.com/docs/concepts/models-and-orm/models

module.exports =

  tableName: 'scmz_user'

  attributes:

    name:
      type:       'string'
      columnType: 'varchar(64)'
      unique:     true
      required:   true

    password:
      type:       'string'
      columnType: 'char(60)'
      required:   true

    email:
      type:       'string'
      columnType: 'varchar(512)'
