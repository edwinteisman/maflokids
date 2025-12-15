<?php get_header(); ?>

<main id="main" class="site-main">
    <?php while (have_posts()) : the_post(); ?>
        <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
            <?php if (is_front_page()) : ?>
                <div class="hero-section">
                    <h1><?php the_title(); ?></h1>
                    <?php if (has_excerpt()) : ?>
                        <p><?php the_excerpt(); ?></p>
                    <?php endif; ?>
                </div>
            <?php else : ?>
                <header class="entry-header">
                    <h1 class="entry-title"><?php the_title(); ?></h1>
                </header>
            <?php endif; ?>

            <div class="entry-content">
                <?php the_content(); ?>

                <?php
                wp_link_pages(array(
                    'before' => '<div class="page-links">' . esc_html__('Pages:', 'maflokids'),
                    'after'  => '</div>',
                ));
                ?>
            </div>
        </article>
    <?php endwhile; ?>
</main>

<?php get_sidebar(); ?>
<?php get_footer(); ?>
