# This represents a single hand (either player or dealer)
# Contains various helper functions to manipulate the hand
class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    _.bindAll @

    @checkForDups(array)

  hit: ->
    @add(@deck.pop())
    @trigger 'hit', @
    @last()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  checkForDups: (array) ->
    if array[0].get('value') is array[1].get('value') then @trigger 'split'
      # if window.confirm 'would you like to split?'
      #   splitHand = true
