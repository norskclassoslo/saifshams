<?php

/*	Exit if .php file accessed directly
*/
if ( !defined( 'ABSPATH' ) ) {
	exit;
}

/*	Must be able to determine Page ID (Action setup_theme is the earliest)
*/
add_action( 'setup_theme', 'jr_mt_convert_url_arrays', JR_MT_RUN_FIRST );

require_once( jr_mt_path() . 'includes/admin-functions.php' );

function jr_mt_convert_url_arrays() {
	$internal_settings = get_option( 'jr_mt_internal_settings' );
	if ( isset( $internal_settings['v6conv'] ) ) {
		unset( $internal_settings['v6conv'] );
		update_option( 'jr_mt_internal_settings', $internal_settings );
	
		$settings = get_option( 'jr_mt_settings' );
		/*	Check if conversion is needed:
			- see if [url*] are all empty arrays - no conversion required
			- look for any [url*]['rel_url'] - already converted from pre-V6
		*/
		if ( is_array( $settings ) ) {
			foreach ( $settings as $setting_key => $arrays ) {
				if ( 'url' === substr( $setting_key, 0, 3 ) ) {
					if ( !empty( $arrays ) ) {
						foreach ( $arrays as $url_array ) {
							if ( isset( $url_array['rel_url'] ) ) {
								/*	Already been converted, so don't do it again.
								*/
								return;
							}
						}
						foreach ( $arrays as $url_key => $url_array ) {
							$url = $url_array['url'];
							if ( jr_mt_same_prefix_url( JR_MT_HOME_URL, $url ) ) {
								$new_url_array['url'] = $url_array['url'];
								$new_url_array['theme'] = $url_array['theme'];
								$rel_url = jr_mt_relative_url( $url, JR_MT_HOME_URL );
								$new_url_array['rel'] = $rel_url;
								/*	Create the URL Prep array for each of the current Site Aliases,
									including the Current Site URL
								*/
								$new_url_array['prep'] = array();
								foreach ( $settings['aliases'] as $index => $alias ) {
									$new_url_array['prep'][] = jr_mt_prep_url( $alias['url'] . '/' . $rel_url );
								}
								/*	Only for URL type Setting, not Prefix types.
								*/
								if ( 'url' === $setting_key ) {
									/*	Try and figure out ID and WordPress Query Keyword for Type, if possible and relevant
									*/
									if ( ( 0 === ( $id = url_to_postid( $url ) ) ) &&
										( version_compare( get_bloginfo( 'version' ), '4', '>=' ) ) ) {
										$id = attachment_url_to_postid( $url );
									}
									if ( !empty( $id ) ) {
										$new_url_array['id'] = $id;
										if ( NULL !== ( $post = get_post( $id ) ) ) {
											switch ( $post->post_type ) {
												case 'post':
													$new_url_array['id_kw'] = 'p';
													break;
												case 'page':
													$new_url_array['id_kw'] = 'page_id';
													break;
												case 'attachment':
													$new_url_array['id_kw'] = 'attachment_id';
													break;
											}
										}
									}
								}
								$settings[ $setting_key ][ $url_key ] = $new_url_array;
							} else {
								/*	Error:
									Cannot convert, as URL is from a different Site Home URL,
									so have to delete this URL entry.
								*/
								unset( $settings[ $setting_key ][ $url_key ] );
							}						
						}
					}
				}
			}
			update_option( 'jr_mt_settings', $settings );
		}
	}
}

?>