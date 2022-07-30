var URL = "https://cors-proxy-yepper.herokuapp.com/https://roc-yepper.herokuapp.com/api/"
var NONE = `<option value="0">--NONE--</option>`
var DATA_SELECT = $(".db-id").map(function() {return $(this).data("select"); }).get();

// Hides all dynamic dropdowns when page loads
$('document').ready(function() {
  hideRest('building', 0);
  let preload = getData(URL + "building/" + 1)
});

// Returns json from api call........WITH NO AJAX!!!
async function getData(url){
  let res = await fetch(url);
  return res.json();
}

// Returns string with first letter set to uppercase
function upCaseFirstLetter(word) {
  return word[0].toUpperCase() + word.substring(1)
}

// Hides every dropdown after the current one
function hideRest(select) {
  for (let i = DATA_SELECT.indexOf(select); i < DATA_SELECT.length; i++) {
    $("#"+DATA_SELECT[i]).hide()
  }
}

// Empties every dropdown after the current one and adds the "--NONE--" option
function purgeRest(select) {
  for (let i = DATA_SELECT.indexOf(select); i < DATA_SELECT.length; i++) {
    $("#" + DATA_SELECT[i] + " select option").remove();
    $("#" + DATA_SELECT[i] + " select").append(NONE)
  }
}

// Calls URL api combined with the specific data-select to return array of ids
async function updateSelect(select, id) {
  let arrID = await getData(URL + select + "/" + id);
  for (let i = 0; i < arrID.length; i++) {
    let text = upCaseFirstLetter(select) + " ID: " + arrID[i];
    let val = arrID[i];
    $("#" + select + " select").append(`<option value="${val}">${text}</option>`);
  }
}

// Checks whenever a element with the class "db-id" changes and updates the next entry to have all the ids from the selection
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