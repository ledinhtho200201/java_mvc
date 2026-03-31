package vn.pildo.laptopshop.controller.client;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.pildo.laptopshop.domain.Product;
import vn.pildo.laptopshop.domain.Review;
import vn.pildo.laptopshop.domain.User;
import vn.pildo.laptopshop.service.ProductService;
import vn.pildo.laptopshop.service.ReviewService;
import vn.pildo.laptopshop.service.UserService;

@Controller
public class ReviewController {

    private final ReviewService reviewService;
    private final ProductService productService;
    private final UserService userService;

    public ReviewController(ReviewService reviewService, ProductService productService, UserService userService) {
        this.reviewService = reviewService;
        this.productService = productService;
        this.userService = userService;
    }

    @PostMapping("/review/add")
    public String addReview(
            @RequestParam("productId") Long productId,
            @RequestParam("content") String content,
            @RequestParam("rating") int rating) {

        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        if (email != null && !email.equals("anonymousUser")) {
            User user = this.userService.getUserByEmail(email);
            Product product = this.productService.getProductById(productId);

            if (user != null && product != null) {
                Review review = new Review();
                review.setUser(user);
                review.setProduct(product);
                review.setContent(content);
                review.setRating(rating);
                this.reviewService.saveReview(review);
            }
        }

        return "redirect:/product/" + productId;
    }
}
