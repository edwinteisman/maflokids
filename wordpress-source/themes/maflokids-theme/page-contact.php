<?php get_header(); ?>

<main id="main" class="site-main">
    <?php while (have_posts()) : the_post(); ?>
        <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
            <header class="entry-header">
                <h1 class="entry-title"><?php the_title(); ?></h1>
            </header>

            <div class="entry-content">
                <?php the_content(); ?>

                <?php if (is_page('contact')) : ?>
                <div class="contact-cta">
                    <h2>Ready to Get Started?</h2>
                    <p>We look forward to hearing from you!</p>
                </div>
                <?php endif; ?>
            </div>
        </article>
    <?php endwhile; ?>
</main>

<?php get_footer(); ?>
