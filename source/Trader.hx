package;

/**
 * ...
 * @author damrem
 */
class Trader 
{
	public function new()
	{
		
	}
	public function fromMarketToInventory(merch:MerchOnPlanet):Bool
	{
		trace("fromMarketToInventory");
		return Inventory.single.buyMerch(merch.name, merch.currentPrice);
	}
	
	public function fromInventoryToMarket(merch:MerchInInventory)
	{
		trace("fromInventoryToMarket");
		var market = PlayState.market;
		market.buyMerch(merch.name);
		
		var merchOnPlanet:MerchOnPlanet = market.planet.merchsByName[merch.name];
		Inventory.single.addCredits(Std.int(merchOnPlanet.currentPrice));
		Inventory.single.removeMerch(merch.name);
	}
	
}