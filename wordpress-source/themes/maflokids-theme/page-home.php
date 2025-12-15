<?php get_header(); ?>

<main id="main" class="site-main">
    <?php while (have_posts()) : the_post(); ?>
        <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
            <div class="hero-section">
                <h1><?php the_title(); ?></h1>
                <p>Welcome to Ma Flo Kids - Your trusted partner for children and families</p>
            </div>

            <div class="entry-content">
                <?php the_content(); ?>
            </div>
        </article>
    <?php endwhile; ?>
</main>

<?php get_footer(); ?>
