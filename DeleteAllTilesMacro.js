const scene = game.canvas.scene.active
const tileData = game.canvas.scene

if (scene) {
    const tilesToDelete = tileData.tiles.map((tile) => tile.id);
    tileData.deleteEmbeddedDocuments("Tile", tilesToDelete);
} else {
    ui.notifications.error('No active scene found.');
}