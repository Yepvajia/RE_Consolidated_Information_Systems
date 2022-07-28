
$("#hello").click(async function(ev){
  ev.preventDefault();
  const juice = await getData("https://cors-proxy-yepper.herokuapp.com/https://roc-yepper.herokuapp.com/api/elevator/"+21)
  console.log(juice[1]);
});

async function getData(url){
  const res = await fetch(url);
  return res.json();
}

$(".db-id").change(function() {
  select = $(this).data("select")
  if (select) console.log(select);
})