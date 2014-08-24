package;

/**
 * ...
 * @author damrem
 */
class Trader 
{
	var inventory:Inventory;
	public function new(_inventory) 
	{
		inventory = _inventory;
	}
	
	public function fromMarketToInventory(merch:MerchOnPlanet)
	{
		trace("fromMarketToInventory");
		inventory.buyMerch(merch.name, merch.currentPrice);
	}
	
	public function fromInventoryToMarket(merch:MerchInInventory)
	{
		trace("fromInventoryToMarket");
		var market = PlayState.currentMarket;
		market.buyMerch(merch.name);
		var merchOnPlanet:MerchOnPlanet = market.place.merchs[merch.name];
		inventory.addCredits(Std.int(merchOnPlanet.currentPrice));
	}
	
}