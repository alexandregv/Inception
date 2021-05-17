<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', getenv('DB_NAME') ?: 'wordpress' );

/** MySQL database username */
define( 'DB_USER', getenv('DB_USER') ?: 'wordpress' );

/** MySQL database password */
define( 'DB_PASSWORD', getenv('DB_PASS') ?: 'wordpress' );

/** MySQL hostname */
define( 'DB_HOST', getenv('DB_HOST') ?: '127.0.0.1' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );


// ** Redis settings ** //
define( 'WP_REDIS_HOST', getenv('WP_REDIS_HOST') ?: '127.0.0.1' );
define( 'WP_REDIS_PORT', getenv('WP_REDIS_PORT') ?: 6379 );
define( 'WP_REDIS_TIMEOUT', getenv('WP_REDIS_TIMOUT') ?: 1 );
define( 'WP_REDIS_READ_TIMEOUT', getenv('WP_REDIS_TIMOUT') ?: 1 );
define( 'WP_REDIS_DATABASE', getenv('WP_REDIS_DATABASE') ?: 0 );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         getenv('AUTH_KEY')         ?: 'S-cQlK^x)kay5n$US0Y7s4XmQq]()p9sWQ1CO`z.</7VZ#mH^5cs-#H::LE{`#<a' );
define( 'SECURE_AUTH_KEY',  getenv('SECURE_AUTH_KEY')  ?: 'z5T}e,&&b]{ +*k]S>$&nR28/t^0 7u.F9;.uNq)Fp<DW[$TfvqRdmtZn;;~R IN' );
define( 'LOGGED_IN_KEY',    getenv('LOGGED_IN_KEY')    ?: 'biH6q;]xS=~go%@1Kaq# %}.fvkKKm0^`?V|Mx{#=p$G]IU.C,1K1DQ&qgK/_CP7' );
define( 'NONCE_KEY',        getenv('NONCE_KEY')        ?: '{WSKY]/ZOu`u>KtLrE<E!d0=@e?38sCvt`3E{O-!RbC@XT~K =:6M|ZuL6y&G.1j' );
define( 'AUTH_SALT',        getenv('AUTH_SALT')        ?: ']_>tM.S!o@|yAj#1o-<Y`1m,qKY_bLU;*:DZ/X9?FDFUnOeE*:J8d6JQK65bQl,=' );
define( 'SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT') ?: '@f&&dY,KbjWGO)heX(ut/D8 eG![ h{hZK&U-+i,Egix#[I7Y}`.Qd2KS]UqX5f<' );
define( 'LOGGED_IN_SALT',   getenv('LOGGED_IN_SALT')   ?: 'yNrS!$qdy]}k<^!&Q5Jai,okd?,HWuc-vcA2$[MHesxc-5YmA!?b#N-6<0)sh6x{' );
define( 'NONCE_SALT',       getenv('NONCE_SALT')       ?: 'g?!]#Ttt{Y38P2^rn[R?$$[?Sq&0L}Bm7L&:-PdE1UROn#B]b Le![$%>RvW>7Zw' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = getenv('DB_TABLE_PREFIX') ?: 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', getenv('WP_DEBUG') ?: false );

/** Add any custom values after this line. */



/**
 * Custom Values must appear above this line.
 *
 * That's all, stop editing! Happy publishing.
 */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
