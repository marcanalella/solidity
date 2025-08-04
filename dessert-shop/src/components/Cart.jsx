import { useCart } from '../context/CartContext';
import { Trash2 } from 'lucide-react';

const EmptyCartSVG = () => (
    <svg width="49" height="49" viewBox="0 0 49 49" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path
            fillRule="evenodd"
            clipRule="evenodd"
            d="M24.5 49c13.528 0 24.5-10.972 24.5-24.5S38.028 0 24.5 0 0 10.972 0 24.5 10.972 49 24.5 49ZM14 18.5a.5.5 0 0 1 .5-.5h20a.5.5 0 0 1 .5.5v20a.5.5 0 0 1-.5.5h-20a.5.5 0 0 1-.5-.5v-20Zm2-17a.5.5 0 0 1 .5.5v2.5a.5.5 0 0 1-1 0V2a.5.5 0 0 1 .5-.5Zm10 0a.5.5 0 0 1 .5.5v2.5a.5.5 0 0 1-1 0V2a.5.5 0 0 1 .5-.5Zm10 0a.5.5 0 0 1 .5.5v2.5a.5.5 0 0 1-1 0V2a.5.5 0 0 1 .5-.5Z"
            fill="#F4EDE8"
        />
        <path
            d="M16 19.5a.5.5 0 0 0 .5.5h16a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-16a.5.5 0 0 0-.5.5v1Z"
            fill="#fff"
        />
        <path
            fillRule="evenodd"
            clipRule="evenodd"
            d="M14 18.5a.5.5 0 0 1 .5-.5h20a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-20a.5.5 0 0 1-.5-.5v-1ZM14 18.5v1h21v-1H14Z"
            fill="#994D3B"
        />
    </svg>
);

export default function Cart() {
    const { cart, removeFromCart, getTotal } = useCart();
    const total = getTotal();

    console.log('Current Cart:', cart);

    return (
        <aside className="bg-white rounded-2xl shadow-md p-6 w-full lg:w-80 flex-shrink-0 h-fit">
            <h2 className="text-xl font-bold text-primary-orange mb-4">Your Cart ({cart.length})</h2>
            {cart.length === 0 ? (
                <div className="mt-8 flex flex-col items-center text-light-gray-text">
                    <EmptyCartSVG />
                    <p className="mt-4 text-center">Your added items will appear here</p>
                </div>
            ) : (
                <div className="flex flex-col h-full">
                    <ul className="mt-2 divide-y divide-gray-100">
                        {cart.map((item, index) => (
                            <li key={item.id || index} className="py-3 text-sm flex items-start justify-between">
                                <div className="flex-1">
                                    <p className="font-medium text-gray-text">{item.name}</p>
                                    <div className="flex items-center space-x-2 text-xs text-gray-400 mt-1">
                                        <span className="text-primary-orange font-bold">{item.quantity}x</span>
                                        <span>@ ${item.price.toFixed(2)}</span>
                                        <span className="font-bold text-gray-text">${(item.quantity * item.price).toFixed(2)}</span>
                                    </div>
                                </div>
                                <button
                                    onClick={() => removeFromCart(item.id)}
                                    className="ml-4 text-gray-400 hover:text-primary-orange transition-colors"
                                >
                                    <Trash2 size={16} />
                                </button>
                            </li>
                        ))}
                    </ul>

                    <div className="mt-4 pt-4 border-t border-gray-100">
                        <div className="flex justify-between items-center text-sm font-semibold mb-4 text-gray-text">
                            <span>Order Total</span>
                            <span className="text-2xl font-bold">${total.toFixed(2)}</span>
                        </div>
                        <button className="w-full bg-primary-orange text-white py-3 rounded-full hover:bg-red-700 transition font-semibold">
                            Confirm Order
                        </button>
                    </div>
                </div>
            )}
        </aside>
    );
}