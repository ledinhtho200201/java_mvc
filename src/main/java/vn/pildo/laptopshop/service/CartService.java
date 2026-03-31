package vn.pildo.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.pildo.laptopshop.domain.CartItem;
import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.repository.CartItemRepository;

@Service
public class CartService {

    private final CartItemRepository cartItemRepository;

    public CartService(CartItemRepository cartItemRepository) {
        this.cartItemRepository = cartItemRepository;
    }

    /** Lấy tất cả item trong giỏ của user */
    public List<CartItem> getCartByUser(User user) {
        return cartItemRepository.findByUser(user);
    }

    /** Đếm tổng số sản phẩm trong giỏ (dùng cho badge) */
    public long countCartItems(User user) {
        return cartItemRepository.countByUser(user);
    }

    /** Tổng tiền */
    public double getTotalPrice(List<CartItem> items) {
        return items.stream()
                .mapToDouble(i -> i.getProduct().getPrice() * i.getQuantity())
                .sum();
    }

    /**
     * Thêm 1 sản phẩm vào giỏ.
     * Nếu sản phẩm đã tồn tại thì tăng quantity thêm 1.
     */
    public void addToCart(User user, Product product) {
        CartItem existing = cartItemRepository.findByUserAndProductId(user, product.getId());
        if (existing != null) {
            existing.setQuantity(existing.getQuantity() + 1);
            cartItemRepository.save(existing);
        } else {
            CartItem item = new CartItem();
            item.setUser(user);
            item.setProduct(product);
            item.setQuantity(1);
            cartItemRepository.save(item);
        }
    }

    /** Xóa 1 item khỏi giỏ theo id */
    public void removeItem(long cartItemId) {
        cartItemRepository.deleteById(cartItemId);
    }

    /** Xóa toàn bộ giỏ của user */
    @Transactional
    public void clearCart(User user) {
        cartItemRepository.deleteByUser(user);
    }

    /** Cập nhật số lượng */
    public void updateQuantity(long cartItemId, int quantity) {
        cartItemRepository.findById(cartItemId).ifPresent(item -> {
            if (quantity <= 0) {
                cartItemRepository.delete(item);
            } else {
                item.setQuantity(quantity);
                cartItemRepository.save(item);
            }
        });
    }
}
