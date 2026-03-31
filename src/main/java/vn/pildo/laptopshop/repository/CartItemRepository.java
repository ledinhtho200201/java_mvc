package vn.pildo.laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.pildo.laptopshop.domain.CartItem;
import vn.pildo.laptopshop.domain.User;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {

    List<CartItem> findByUser(User user);

    CartItem findByUserAndProductId(User user, long productId);

    void deleteByUser(User user);
}
