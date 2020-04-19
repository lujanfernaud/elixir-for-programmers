import { Socket } from 'phoenix'

export default class HangmanSocket {
  constructor(tally) {
    this.tally = tally
    this.socket = new Socket('/socket', {})
    this.socket.connect()
  }

  connectToHangman() {
    this.setupChannel()

    this.channel.on('tally', (tally) => {
      this.copyTally(tally)
    })
  }

  setupChannel() {
    this.channel = this.socket.channel('hangman:game', {})
    this.channel
      .join()
      .receive('ok', (response) => {
        console.log('Joined successfully', response)
        this.fetchTally()
      })
      .receive('error', (response) => {
        alert('Unable to join', response)
        throw response
      })
  }

  fetchTally() {
    this.channel.push('tally', {})
  }

  makeMove(guess) {
    this.channel.push('make_move', guess)
  }

  newGame() {
    this.channel.push('new_game', {})
  }

  copyTally(from) {
    for (let k in from) {
      this.tally[k] = from[k]
    }
  }
}
