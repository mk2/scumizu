$(function() {
  // UI要素周り
  $(".ui.stciker").sticky({context: "#content"});

  var Scumizu = window.Scumizu || {};

  var POST  = 'POST';
  var GET   = 'GET';
  var PATCH = 'PATCH';

  $.extend(Scumizu, {
    version: "0.0.1",
    vm: {},
    baseUrl: "/api",

    /**
     *
     * @param {} path
     * @param {} obj
     * @returns {Promise} リクエストのプロミス
     */
    willPatchJson: function(path, obj) {
      return $.ajax({
        method:   PATCH,
        url:      Scumizu.baseUrl + path + '/' + obj.id,
        data:     obj,
        dataType: 'json',
        cache:    false
      });
    },
    willPatchJsons: function(pathObjPairs) {
      var deffereds = $.map(pathObjPairs, function(pathObjPair) {
        return Scumizu.willPatchJson(pathObjPair[0], pathObjPair[1]);
      });
      return $.when.apply(null, deffereds);
    },
    /**
     * @param {string} path
     * @param {object} obj
     * @returns {Promise}
     */
    willPostJson: function(path, obj) {
      return $.ajax({
        method:   POST,
        url:      Scumizu.baseUrl + path,
        data:     obj,
        dataType: 'json',
        cache:    false
      });
    },
    /**
     * @param {array<string, string>} pathObjPairs
     * @returns {Promise}
     */
    willPostJsons: function(pathObjPairs) {
      var defferreds = $.map(pathObjPairs, function(pathObjPair) {
        return Scumizu.willPostJson(pathObjPair[0], pathObjPair[1]);
      });
      return $.when.apply(null, deferreds);
    },
    /**
     * @param {string} path
     * @returns {Promise}
     */
    willGetJson: function(path) {
      return $.get(Scumizu.baseUrl + path);
    },
    log: console.log
  });

  window.Scumizu = Scumizu;
});
