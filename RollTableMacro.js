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
		console.log("Executed Roll:", executedRoll);
		producedResults.push(result.results);
	}

    // Handle the results here
    
    console.log("Produced Results:", producedResults);
    
    /* List of tile image options */
	
     // Create the tile inside the .then() block
	 for(let i = 0; i < numberOfDraws; i++){
		const test = producedResults[i];
		const test2 = test[0];
		 const currentImageData = imageData(i,test2.img, test2.text);
		 const testArray = [currentImageData.name,  currentImageData.img, currentImageData.width, currentImageData.height];
		 return canvas.scene.createEmbeddedDocuments("Token", testArray);
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
  
  function imageData(i, imageSrc, imageName){
	  //Defining tile data
	  return {
		name: imageName,
		img: imageSrc,
		width: 1000,
        height: 1000,
        x: 0 + i*(1000 + 50),
        y: 0,
    };
  }