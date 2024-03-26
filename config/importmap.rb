# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'popper', to: 'https://unpkg.com/@popperjs/core@2/dist/umd/popper.js'
pin 'bootstrap', to: 'https://unpkg.com/bootstrap@5/dist/js/bootstrap.min.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
