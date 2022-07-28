var URL = "https://cors-proxy-yepper.herokuapp.com/https://roc-yepper.herokuapp.com/api/"
var NONE = `<option value="0">--NONE--</option>`
var IDS = $(".db-id").map(function() {return $(this).attr("id"); }).get().slice(1);
var ELEMENTS = IDS.concat(['employee', 'report', 'sub-button'])

$('document').ready(function() {
  hideRest('building', 0);
});

// $("#hello").click(async function(ev){
//   // ev.preventDefault();
//   // let juice = await getData("https://cors-proxy-yepper.herokuapp.com/https://roc-yepper.herokuapp.com/api/elevator/"+21)
//   // console.log(juice[1]);
//   console.log(IDS);
//   console.log(ELEMENTS);
// });


async function getData(url){
  let res = await fetch(url);
  return res.json();
}

function upCaseFirstLetter(word) {
  return word[0].toUpperCase() + word.substring(1)
}

function hideRest(select) {
  for (let i = ELEMENTS.indexOf(select); i < ELEMENTS.length; i++) {
    $("#"+ELEMENTS[i]).hide()
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
    if (select == "done") {
      hideRest("employee")
      for (let i = 0; i < ELEMENTS.length; i++) {
        $("#"+ELEMENTS[i]).show(500)
      }
    } else {
      hideRest(select)
      purgeRest(select)
      $('#'+select).show(500)
    }
    updateSelect(select, id)
  } else {
      if (select == "done") {
        hideRest("employee")
      } else {
        hideRest(select)
        purgeRest(select)
      }
  }
});