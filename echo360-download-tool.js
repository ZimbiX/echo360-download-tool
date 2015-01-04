// Paste jQuery source first

var delay = 1000;
var course = $('#course-info').text();
var downloads = [];
var echoes = $('#echoes-list > li');
scheduleGetNextVideoUrl(0, echoes.length - 1);

// This function from: http://stackoverflow.com/a/10073788
function pad(n, width, z) {
  z = z || '0';
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

function numericReplaceMonth(rawDate) {
  var months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  var numericReplacedMonth;
  $(months).each(function(i, month) {
    if (new RegExp(month + ' ').test(rawDate)) {
      numericMonth = pad(i+1, 2);
      numericReplacedMonth = rawDate.replace(month + ' ', numericMonth + '-');
    }
  });
  return numericReplacedMonth;
}

function getNextVideoUrl(i, max) {
  var download = {}

  var currentYear = new Date().getFullYear();
  var rawDate = $('.date-value').text();
  var date = currentYear + '-' + numericReplaceMonth(rawDate);

  var title = course + ' ' + date;
  var url = $('.info-value a[title~=Video]').attr('href');
  url = url.replace('media.m4v', 'mediacontent.m4v');
  title = title.replace(':', '.');

  console.log(title);
  console.log(url);
  download['url'] = url;
  download['title'] = title;
  downloads.push(download);
  scheduleGetNextVideoUrl(i+1, max);
}

function scheduleGetNextVideoUrl(i, max) {
  if (i <= max) {
    echoes[i].click();
    setTimeout(function() {
      getNextVideoUrl(i, max);
    }, delay);
  } else {
    done();
  }
}

function done() {
  console.log('Done');
  $('body').children().remove();
  var list = document.createElement('ul');
  $(downloads).each(function() {
    var li = document.createElement('li');
    var a = document.createElement('a');
    href = document.createAttribute('href');
    href.value = this['url'];
    a.setAttributeNode(href);
    var title = document.createTextNode(this['title']);
    a.appendChild(title);
    li.appendChild(a);
    list.appendChild(li);
  })
  document.body.appendChild(list);
}