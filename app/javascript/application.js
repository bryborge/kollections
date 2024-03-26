// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"

// Delete [Collection | Item] confirmation dialog box
//   e.g. app/views/collections/edit.html.erb
document.addEventListener("turbo:click", function(event) {
  const element = event.target
  const confirmMessage = element.getAttribute("data-turbo-confirm")
  if (!confirmMessage || window.confirm(confirmMessage)) {
    return true
  }

  event.preventDefault()
  return false
})
