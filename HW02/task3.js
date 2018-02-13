(function () {
  'use strict';
  function loremClick(e) {
    var paras = document.querySelectorAll('.loremPara');
    var beerparas = document.querySelectorAll('.beer');
    var thirdpara = document.querySelectorAll('.third');

    for (var i = 0; i < paras.length; i++) {
      paras[i].style = 'display: block';
    }

    for (var ii = 0; ii < beerparas.length; ii++) {
      beerparas[ii].style = 'display: none';
    }

    for (var a = 0; a < thirdpara.length; a++) {
      thirdpara[a].style = 'display: none';
    }
  }

  function bottlesClick(e) {
    var paras = document.querySelectorAll('.loremPara');
    var beerparas = document.querySelectorAll('.beer');
    var thirdpara = document.querySelectorAll('.third');

    for (var i = 0; i < paras.length; i++) {
      paras[i].style = 'display: none';
    }

    for (var ii = 0; ii < beerparas.length; ii++) {
      beerparas[ii].style = 'display: block';
    }

    for (var a = 0; a < thirdpara.length; a++) {
      thirdpara[a].style = 'display: none';
    }
  }

  function thirdClick(e) {
    var paras = document.querySelectorAll('.loremPara');
    var beerparas = document.querySelectorAll('.beer');
    var thirdpara = document.querySelectorAll('.third');

    for (var i = 0; i < paras.length; i++) {
      paras[i].style = 'display: none';
    }

    for (var ii = 0; ii < beerparas.length; ii++) {
      beerparas[ii].style = 'display: none';
    }

    for (var a = 0; a < thirdpara.length; a++) {
      thirdpara[a].style = 'display: block';
    }
  }

  var link1 = document.getElementById('lorem');
  link1.onclick = loremClick;

  var link2 = document.getElementById('bottles');
  link2.onclick = bottlesClick;

  var link3 = document.getElementById('thing');
  link3.onclick = thirdClick;

})();
