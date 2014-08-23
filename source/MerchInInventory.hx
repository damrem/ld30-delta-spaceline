package;

/**
 * ...
 * @author damrem
 */
class MerchInInventory 
{
	var inUniv:MerchInUniv;
	var quantity:UInt;
	
	public function new(InUniv:MerchInUniv, Quantity:UInt=0) 
	{
		inUniv = InUniv;
		quantity = Quantity;
	}
}