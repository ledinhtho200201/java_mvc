package vn.pildo.laptopshop.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.domain.Review;
import vn.pildo.laptopshop.repository.ReviewRepository;

@Service
public class ReviewService {
    
    private final ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    public Review saveReview(Review review) {
        return this.reviewRepository.save(review);
    }

    public Page<Review> getReviewsByProduct(Product product, Pageable pageable) {
        return this.reviewRepository.findByProductOrderByCreatedAtDesc(product, pageable);
    }

    public double getAverageRating(Product product) {
        return this.reviewRepository.getAverageRatingByProduct(product);
    }

    public long countReviews(Product product) {
        return this.reviewRepository.countByProduct(product);
    }
}
