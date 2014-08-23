package;
import MercInUniv;
class MercOnPlanet
{
	public var inUniverse:MercInUniv;
	public var quantity:UInt;
	public var currentPrice:Float;
	public var availability:Float;
	
	public function new(InUniverse:MercInUniv, CurrentPrice:Float, Avalaibility:Float)
	{
		inUniverse = InUniverse;
		quantity = Std.int(availability * 10);
		currentPrice = CurrentPrice;
		availability = Avalaibility;
	}
}