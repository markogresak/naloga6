$ ->
  $('.rating').raty
    score: -> $(this).data 'rating'
    path: '/assets'
    click: (score) -> $.post "/rate/#{$(this).data 'movie'}/#{score}"; true
