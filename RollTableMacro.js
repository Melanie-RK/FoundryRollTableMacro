data = {}

numberOfDraws = 8
imageWidth = 1000;
imageHeight = 1000;

tableName = 'Bofa'

game.tables.getName(tableName).draw().then((result) => {
    // The draw operation was successful    
    const producedResults = [];
	for(let i = 0; i < numberOfDraws; i++){
		const executedRoll = result.roll;
		producedResults.push(result.results);
	}

    // Handle the results here
    console.log("Executed Roll:", executedRoll);
    console.log("Produced Results:", producedResults);

    // You can perform further actions with the results
    console.log(producedResults.img)
    
    /* List of tile image options */
    const img = producedResults.img;
   
     // Create the tile inside the .then() block
	 for(let i = 0; i < numberOfDraws; i++){
		 currentImageData = imageData(i,img[i]);
		 return canvas.scene.createEmbeddedDocuments('Tile', [currentImageDatamageData]);
	 }
     
  })
   .then((createdTiles) => {
     // Handle the created tiles here if needed
     console.log("Created Tiles:", createdTiles);
   })
  .catch((error) => {
    // Handle any errors that may occur during the draw
    console.error("Error during draw:", error);
  });
  
  function imageData(i, imageSrc){
	  //Defining tile data
	  data = {
        x: 0 + i*(imageWidth + 50),
        y: 0,
        width: imageWidth,
        height: imageHeight,
        texture: {src: imageSrc},
    }
	return[data];
  }