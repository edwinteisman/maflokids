// Ma Flo Kids Theme JavaScript

jQuery(document).ready(function($) {

    // Smooth scrolling for anchor links
    $('a[href*="#"]').on('click', function(e) {
        var target = $(this.getAttribute('href'));

        if (target.length) {
            e.preventDefault();
            $('html, body').stop().animate({
                scrollTop: target.offset().top - 100
            }, 1000);
        }
    });

    // Mobile menu toggle (if needed)
    $('.menu-toggle').on('click', function() {
        $('.main-navigation').toggleClass('active');
    });

    // Form validation
    $('.contact-form form').on('submit', function(e) {
        var isValid = true;

        $(this).find('input[required], textarea[required]').each(function() {
            if ($(this).val().trim() === '') {
                $(this).addClass('error');
                isValid = false;
            } else {
                $(this).removeClass('error');
            }
        });

        if (!isValid) {
            e.preventDefault();
            alert('Please fill in all required fields.');
        }
    });

    // Remove error class on input
    $('input, textarea').on('focus', function() {
        $(this).removeClass('error');
    });

    // Add loading state to buttons
    $('.btn, .cta-button').on('click', function() {
        if ($(this).closest('form').length) {
            $(this).text('Sending...').prop('disabled', true);
        }
    });

    // Scroll to top functionality
    $(window).scroll(function() {
        if ($(this).scrollTop() > 100) {
            $('.scroll-to-top').fadeIn();
        } else {
            $('.scroll-to-top').fadeOut();
        }
    });

    // Initialize any animations or special effects here
    console.log('Ma Flo Kids Theme loaded successfully!');

});
