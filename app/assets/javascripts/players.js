class Player {
  constructor(attr){
    this.name = attr.name
    this.specialty = attr.specialty
    this.leader = attr.leader
  }
  renderPlayer() {
    return 'Name: <a href="#" onclick="playerData(' + this.id + ')">' + this.name + '</a>'
  }
}

let allPlayers = []

function showPlayers(){
  const playerList = document.querySelector('#listArea')
  const playerUL = document.createElement('ul')
  playerUL.setAttribute('id', 'playerList')
  playerList.innerHTML = '<h3>Player</h3>'
  playerList.appendChild(playerUL)

  const req = new XMLHttpRequest()
  allPlayers = []
  req.open('GET', '/players')
  req.responseType = 'json'
  req.send()
  req.onload = function(){
    req.response.forEach(function(i){
      let player = new Player(i)
      allPlayers.push(player)
      let playerLi = document.createElement('li')
      playerLi.innerHTML = player.renderPlayer()
      playerUL.appendChild(playerLi)
    })
  }
}
