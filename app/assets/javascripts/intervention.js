
$("#hello").click(function(ev){
  ev.preventDefault();
  // var juice
  fetch("https://cors-proxy-yepper.herokuapp.com/https://roc-yepper.herokuapp.com/api/elevator/"+21)
    .then((response) => response.json())
    .then((data) => console.log(data));
  // console.log(juice);
});

$(".db-id").change(function() {
  console.log("JUICE");
})