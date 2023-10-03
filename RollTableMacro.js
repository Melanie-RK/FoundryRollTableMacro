numberOfDraws = 8;

for(let i = 0; i < numberOfDraws; i++){
	drawCard(i);
}


function drawCard(drawIndex){
	game.tables.getName('Bofa').draw().then((result)=>
{
const producedResults = result.results;
    console.log("Produced Results:", producedResults);
console.log(tables2)
const tileCreationData={
name: producedResults[0].text,
img: producedResults[0].img,
width: 1000,
height: 1000,
x: (drawIndex*50),
y: 0,
}
const testCreationDataArray = [tileCreationData];
console.log("Test array: ", testCreationDataArray);
const tileCreationDataArray = testCreationDataArray[0];
console.log("X value: ", tileCreationDataArray[4]);
canvas.scene.createEmbeddedDocuments("Tile", tileCreationDataArray)
})
}

