package vn.pildo.laptopshop.service;

import org.springframework.stereotype.Service;

import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.domain.Review;
import vn.pildo.laptopshop.repository.ReviewRepository;

import java.util.List;

@Service
public class ReviewService {
    
    private final ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    public Review saveReview(Review review) {
        return this.reviewRepository.save(review);
    }

    public List<Review> getReviewsByProduct(Product product) {
        return this.reviewRepository.findByProductOrderByCreatedAtDesc(product);
    }
}
