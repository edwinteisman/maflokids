<?php get_header(); ?>

<main id="main" class="site-main">
    <?php if (have_posts()) : ?>
        <header class="page-header">
            <h1 class="page-title">
                <?php
                printf(esc_html__('Search Results for: %s', 'maflokids'), '<span>' . get_search_query() . '</span>');
                ?>
            </h1>
        </header>

        <?php while (have_posts()) : the_post(); ?>
            <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
                <header class="entry-header">
                    <h2 class="entry-title">
                        <a href="<?php the_permalink(); ?>" rel="bookmark"><?php the_title(); ?></a>
                    </h2>
                </header>

                <div class="entry-summary">
                    <?php the_excerpt(); ?>
                </div>
            </article>
        <?php endwhile; ?>

        <?php the_posts_navigation(); ?>

    <?php else : ?>
        <section class="no-results not-found">
            <header class="page-header">
                <h1 class="page-title"><?php esc_html_e('Nothing here', 'maflokids'); ?></h1>
            </header>

            <div class="page-content">
                <p><?php esc_html_e('Sorry, but nothing matched your search terms. Please try again with some different keywords.', 'maflokids'); ?></p>
                <?php get_search_form(); ?>
            </div>
        </section>
    <?php endif; ?>
</main>

<?php get_sidebar(); ?>
<?php get_footer(); ?>
