const scene = game.canvas.scene.active
const data = game.canvas.scene

if(scene){
console.log("Scene active");
console.log("Scene: ", scene);
console.log("Data.tiles: ", data.tiles);
const tiles = data.tiles;
console.log("Tiles: ", tiles);
 const tileIds = tiles.map((tile) => tile._id);
 
 /*
    canvas.tiles.selectObjects({ objects: tileIds });
    canvas.tiles.deleteSelected();*/
}