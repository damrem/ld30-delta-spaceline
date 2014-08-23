package;

/**
 * ...
 * @author damrem
 */
class Trader 
{
	var market:Market;
	var inventory:Inventory;
	public function new(_market, _inventory) 
	{
		market = _market;
		inventory = _inventory;
	}
	
	public function toInventory(merch:MerchOnPlanet)
	{
		inventory.addMerchType(new MerchInInventory(merch.inUniv));
	}
	
}