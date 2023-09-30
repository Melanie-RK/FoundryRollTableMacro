numberOfDraws = 8;
imageWidth = 250;
imageHeight = 500;

tableName = 'Bofa';

game.tables.getName(tableName).drawMany(numberOfDraws).then((result) => {
    // The draw operation was successful    
    producedResults = result.results;
	for(let i = 0; i < numberOfDraws; i++){
		drawnCards = []
		
		// Check if any cards were sticky
		if(producedResults[i].text.toLowerCase().includes("sticky")) {
			// Todo: Sticky card found, roll twice more and make sure you get two more results that do not contain the strings "shuffle" or "sticky" inside them.
			// Todo: Add the newly rolled cards to the drawnCards array.
			const stickyCardIndex = i;
			let additionalRolls = 2; // You want to roll twice more

			// Function to roll and filter results
			const rollAndFilter = async () => {
				const additionalResults = await game.tables.getName(tableName).drawMany(additionalRolls);

				for (const additionalResult of additionalResults.results) {
					if (!additionalResult.text.toLowerCase().includes("shuffle") && !additionalResult.text.toLowerCase().includes("sticky")) {
						if(additionalRolls == 1) {
							additionalResult.flags.sticky = 'sticky';
						}
						drawnCards.push(additionalResult);
						additionalRolls--; // Decrease the number of additional rolls needed
						if (additionalRolls === 0) break; // Stop rolling if you have enough results
					}
				}

				if (additionalRolls > 0) {
					// If you still need more results, recursively call rollAndFilter
					await rollAndFilter();
				}
			};

			// Start rolling and filtering
			rollAndFilter();
		} else {
			drawnCards.push(producedResults[i]);
		}
		// Spawn a new tile on the map for each drawn card inside drawnCards.
		for(let cardIndex = 0; cardIndex < drawnCards.length; cardIndex++) {
			const statusValues = Object.values(drawnCards[cardIndex].flags);
			if (statusValues.includes('sticky')) {
				currentImageData = imageData(i-1, 1, drawnCards[cardIndex].img, drawnCards[cardIndex].text);				
				// Define the message content
				messageContent = "Sticky card below nr #" + i + " is " + drawnCards[cardIndex].text;

				// Create the private GM message
				ChatMessage.create({
				  content: messageContent,
				  whisper: ["GM"], // Set the whisper target to "GM"
				});
			} else {
				currentImageData = imageData(i, 0, drawnCards[cardIndex].img, drawnCards[cardIndex].text);
				// Define the message content
				messageContent = "Card nr #" + (i+1) + " is " + drawnCards[cardIndex].text;

				// Create the private GM message
				ChatMessage.create({
				  speaker: ChatMessage.getSpeaker({actor}),
				  content: messageContent,
				  whisper: ChatMessage.getWhisperRecipients('GM'), // Set the whisper target to "GM"
				});
			}
			canvas.scene.createEmbeddedDocuments('Tile', [currentImageData]);
		}
	}
  }).catch((error) => {
    // Handle any errors that may occur during the draw
    console.error("Error during draw:", error);
  });
  
  function imageData(cardIndex, stickyIndex, imageSrc, imageName){
	  //Defining tile data
	  return {
		img: imageSrc,
		name: imageName,
		width: imageWidth,
		height: imageHeight,
		x: 100 + cardIndex*(imageWidth + 50),
		y: 100 + stickyIndex*50
    };
  }