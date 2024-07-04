extends CanvasLayer

var coins = 0

func _ready():
	
	$CoinsCollectedText.text = String(coins)

func handleCoinCollected():
	print ("Moneda obtenida")
	coins += 1
	$CoinsCollectedText.text = String(coins)
