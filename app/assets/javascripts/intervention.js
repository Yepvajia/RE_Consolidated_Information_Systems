var URL = "https://cors-proxy-yepper.herokuapp.com/https://roc-yepper.herokuapp.com/api/"
var NONE = `<option value="0">--NONE--</option>`
var IDS = $(".db-id").map(function() {return $(this).data("select"); }).get();

$('document').ready(function() {
  hideRest('building', 0);
});

async function getData(url){
  let res = await fetch(url);
  return res.json();
}

function upCaseFirstLetter(word) {
  return word[0].toUpperCase() + word.substring(1)
}

function hideRest(select) {
  for (let i = IDS.indexOf(select); i < IDS.length; i++) {
    $("#"+IDS[i]).hide()
  }
}

function purgeRest(select) {
  for (let i = IDS.indexOf(select); i < IDS.length; i++) {
    $("#" + IDS[i] + " select option").remove();
    $("#" + IDS[i] + " select").append(NONE)
  }
}

async function updateSelect(select, id) {
  let arrID = await getData(URL + select + "/" + id);
  for (let i = 0; i < arrID.length; i++) {
    let text = upCaseFirstLetter(select) + " ID: " + arrID[i];
    let val = arrID[i];
    $("#" + select + " select").append(`<option value="${val}">${text}</option>`);
  }
}

$(".db-id").change(function() {
  select = $(this).data("select");
  id = $(this).find(":selected").val();
  if (id != 0) {
    hideRest(select)
    purgeRest(select)
    $('#'+select).show(700)
    updateSelect(select, id)
  } else {
    hideRest(select)
    purgeRest(select)
  }
});

// $("#hello").click(async function(ev){
//   // ev.preventDefault();
//   // let juice = await getData("https://cors-proxy-yepper.herokuapp.com/https://roc-yepper.herokuapp.com/api/elevator/"+21)
//   // console.log(juice[1]);
//   console.log(IDS);
//   console.log(ELEMENTS);
// });