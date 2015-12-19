# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.

# Initializes the game. 
class window.App extends Backbone.Model
  initialize: ->
    _.bindAll @
    @set 'deck', deck = new Deck()
    newPlayer = deck.dealPlayer()
    newPlayerArr = []
    newPlayerArr.push newPlayer
    @set 'playerHands', newPlayerArr
    @set 'dealerHand', deck.dealDealer()
    playerHands = @get 'playerHands'
    dealerHand = @get 'dealerHand'
    playerHands = @get 'playerHands'
    deck = @get 'deck'
    gameModel = new Game(playerHands: playerHands, dealerHand: dealerHand, deck: deck)
    @set 'gameModel', gameModel
    gameEnd = @get 'gameModel'
    gameEnd.bind 'gameEnd', @newGame

  newGame: ->
    newPlayerOnGameEnd = @get('deck').dealPlayer()
    newDealerOnGameEnd = @get('deck').dealDealer()
    @set 'playerHands', [newPlayerOnGameEnd]
    @set 'dealerHand', newDealerOnGameEnd
    playerHandsOnGameEnd = @get 'playerHands'
    dealerHandOnGameEnd = @get 'dealerHand'
    test = @get('gameModel')
    test.set 'playerHands', playerHandsOnGameEnd
    test.set 'dealerHand', dealerHandOnGameEnd
