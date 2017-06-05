$(function() {
  // UI要素周り
  $(".ui.stciker").sticky({context: "#content"});

  var Scumizu = window.Scumizu || {};

  $.extend(Scumizu, {
    version: "0.0.1",
    vm: {},
    baseUrl: "",
    willPatchJson: function(path, obj) {
      delete obj['updatedAt'];
      return $.ajax({
        method: 'PATCH',
        url: Scumizu.baseUrl + path + '/' + obj.id,
        data: obj,
        dataType: 'json',
        cache: false
      });
    },
    willPatchJsons: function(pathObjPairs) {
      var deffereds = pathObjPairs.map(function(pathObjPair) {
        return Scumizu.willPatchJson(pathObjPair[0], pathObjPair[1]);
      });
      return $.when.apply(null, deffereds);
    },
    willPostJson: function(path, obj) {
      return $.ajax({
        method: 'POST',
        url: Scumizu.baseUrl + path,
        data: obj,
        dataType: 'json',
        cache: false
      });
    },
    willPostJsons: function(pathObjPairs) {
      var defferreds = pathObjPairs.map(function(pathObjPair) {
        return Scumizu.willPostJson(pathObjPair[0], pathObjPair[1]);
      });
      return $.when.apply(null, deferreds);
    },
    willGetJson: function(path) {
      return $.get(Scumizu.baseUrl + path);
    },
    log: console.log
  });

  window.Scumizu = Scumizu;
});
