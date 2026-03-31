package vn.pildo.laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.domain.Review;
import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    
    // For pagination
    Page<Review> findByProductOrderByCreatedAtDesc(Product product, Pageable pageable);
    
    // For average rating calculation
    @Query("SELECT COALESCE(AVG(r.rating), 0.0) FROM Review r WHERE r.product = :product")
    Double getAverageRatingByProduct(@Param("product") Product product);
    
    // For counting total reviews
    long countByProduct(Product product);
}
