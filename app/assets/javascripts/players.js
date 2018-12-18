class Player {
  constructor(attr){
    this.id = attr.id
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

function playerData(player_id) {
  let moreData = document.getElementById('moreData')
  const req = new XMLHttpRequest()
  req.open('GET', "players/" + `${player_id}`)
  req.responseType = 'json'
  req.send()
  req.onload = function() {
    let player = new Player(req.response)
    moreData.innerHTML = '<br /><h3> Additional Player Info</h3><strong><h4> ' + player.name +  '</strong></h4><strong></p>' + player.specialty + '</strong></p>'
    playerul = document.createElement('ul')
    moreData.appendChild(playerul)

  }
}