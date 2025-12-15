        </div>
    </div><!-- #content -->

    <footer id="colophon" class="site-footer">
        <div class="container">
            <div class="footer-content">
                <?php if (is_active_sidebar('footer-1')) : ?>
                    <div class="footer-widgets">
                        <?php dynamic_sidebar('footer-1'); ?>
                    </div>
                <?php else : ?>
                    <div class="footer-widget">
                        <h4>Contact Info</h4>
                        <p>Ma Flo Kids<br>
                        [Your Address]<br>
                        [Your Phone] | [Your Email]</p>
                    </div>

                    <div class="footer-widget">
                        <h4>Quick Links</h4>
                        <?php
                        wp_nav_menu(array(
                            'theme_location' => 'footer',
                            'container'      => false,
                            'fallback_cb'    => false,
                        ));
                        ?>
                    </div>

                    <div class="footer-widget">
                        <h4>Follow Us</h4>
                        <p>Connect with us on social media for updates and news.</p>
                    </div>
                <?php endif; ?>
            </div>

            <div class="footer-bottom">
                <p>&copy; <?php echo date('Y'); ?> <?php bloginfo('name'); ?>. All rights reserved.</p>
            </div>
        </div>
    </footer>
</div><!-- #page -->

<?php wp_footer(); ?>
</body>
</html>
