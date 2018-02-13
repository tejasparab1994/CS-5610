(function () {
  'use strict';

  function currentVal() {
    var headVal = document.getElementById('top').innerHTML;
    alert('Current Val of number is ' + headVal);

  }

  function newVal(e) {
    var headVal = document.getElementById('top').innerHTML;
    var newVal = Number(headVal) + 1;

    document.getElementById('top').innerHTML = newVal;
  }

  function append() {
    var headVal = document.getElementById('top').innerHTML;

    var x = document.getElementById('appendPara');
    var t = document.createTextNode(headVal);
    var br = document.createElement('br');
    x.appendChild(t);
    x.appendChild(br);

    document.body.appendChild(x);

  }

  var link1 = document.getElementById('btn');
  link1.onclick = currentVal;

  var link2 = document.getElementById('btn2');
  link2.onclick = newVal;

  var link3 = document.getElementById('btn3');
  link3.onclick = append;

})();
