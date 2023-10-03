numberOfDraws = 8;
imageWidth = 250;
imageHeight = 500;

tableName = 'Bofa';

messages = [];

async function main() {
	try {
		const result = await game.tables.getName(tableName).drawMany(numberOfDraws, {rollMode : CONST.DICE_ROLL_MODES.PRIVATE});
		
		// The draw operation was successful    
		producedResults = structuredClone(result.results);
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
					const additionalResults = await game.tables.getName(tableName).drawMany(2, {rollMode : CONST.DICE_ROLL_MODES.PRIVATE});

					for (additionalResult of additionalResults.results) {
						if (!additionalResult.text.toLowerCase().includes("shuffle") && !additionalResult.text.toLowerCase().includes("sticky")) {
							if(additionalRolls === 1) {
								additionalResult.flags.sticky = 'sticky';
							} else {
								additionalResult.flags.sticky = '';
							}
							console.log("Pushing additional card into draw pile");
							drawnCards.push(structuredClone(additionalResult));
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
				await rollAndFilter();
				
				// Todo: This code deletes rolls but the timing is off due to async draw calls. Please fix!
				//setTimeout(() => {
				//	result.roll.toMessage().then((message) => {
				//		message.delete();
				//	});
				//	additionalResults.roll.toMessage().then((message) => {
				//		message.delete();
				//	});
				//}, 100);
				
			} else {
				producedResults[i].flags.sticky = '';
				drawnCards.push(producedResults[i]);
			}
			
			console.log("Drawn cards", drawnCards);
			
			// Spawn a new tile on the map for each drawn card inside drawnCards.
			for(let cardIndex = 0; cardIndex < drawnCards.length; cardIndex++) {
				const statusValues = Object.values(drawnCards[cardIndex].flags);
				cardNr = i+1
				if (statusValues.includes('sticky')) {
					currentImageData = imageData(i, 1, drawnCards[cardIndex].img, drawnCards[cardIndex].text);				
					// Define the message content
					messageContent = "Sticky card below nr #" + cardNr + " is " + drawnCards[cardIndex].text;
					messages.push(messageContent)
				} else {
					currentImageData = imageData(i, 0, drawnCards[cardIndex].img, drawnCards[cardIndex].text);
					// Define the message content
					messageContent = "Card nr #" + cardNr + " is " + drawnCards[cardIndex].text;
					messages.push(messageContent)
				}
				console.log(currentImageData);
				canvas.scene.createEmbeddedDocuments('Tile', [currentImageData]);
			}
		}
	} catch (error) {
		// Handle any errors that may occur during the draw
		console.error("Error during draw:", error);
	}
	
	await new Promise(r => setTimeout(r, 500));
	
	for (let i = 0; i < messages.length; i++) {
		// Create the private GM message
		await ChatMessage.create({
		  speaker: ChatMessage.getSpeaker({actor: actor}),
		  content: messages[i],
		  whisper: ChatMessage.getWhisperRecipients('GM'), // Set the whisper target to "GM"
		});
	}
}
  
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
  
  main();