package ;

/**
 * ...
 * @author damrem
 */
class Merch
{
	public var name:String;
	public var quantity:UInt;
	public static var refPrices:Map<String, Float> = new Map<String, Float>();
	
	public function new(Name:String, Quantity:UInt=0) 
	{
		name = Name;
		quantity = Quantity;
	}
	
	function get_refPrice():Float 
	{
		return refPrices[name];
	}
	
	public var refPrice(get_refPrice, null):Float;
	
	
	
}