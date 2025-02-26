# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( quote.js )
Rails.application.config.assets.precompile += %w( intervention.js )
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
# Rails.application.config.assets.precompile += %w( header-1.css )
# Rails.application.config.assets.precompile += %w( color_scheme/blue.css )
# Rails.application.config.assets.precompile += %w( layout )
# Rails.application.config.assets.precompile += %w( essentials )
# Rails.application.config.assets.precompile += %w( plugins/slider.revolution/css/extralayers.css )
# Rails.application.config.assets.precompile += %w( plugins/slider.revolution/css/settings.css )
# Rails.application.config.assets.precompile += %w( scripts )
# Rails.application.config.assets.precompile += %w( plugins/slider.revolution/js/jquery.themepunch.revolution.min.js )
# Rails.application.config.assets.precompile += %w( js/contact.js )
# Rails.application.config.assets.precompile += %w( plugins/jquery/jquery-3.3.1.min.js )
# Rails.application.config.assets.precompile += %w( plugins/owl-carousel/owl.carousel.min.js )
# Rails.application.config.assets.precompile += %w( plugins/slider.revolution/js/jquery.themepunch.tools.min.js )
