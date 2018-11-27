class Team {
  constructor(attr) {
    this.id = attr.id
    this.name = attr.name
    this.type_player = attr.type_player
    this.role = attr.role
    this.quote = attr.quote
  }
  renderTeam() {
    return 'Name: <a href="#" onclick="teamData(' + this.id + ')">' + this.name + '</a>'
  }
}

let allTeams = []

function getTeams() {
  const teamsList = document.querySelector('#listArea')
  const teamsUL = document.createElement('ul')
  teamsUL.setAttribute('id', 'teamsList')
  teamsList.innerHTML = "<h3>Teams</h3>"
  teamsList.appendChild(teamsUL)

  const req = new XMLHttpRequest()
  allTeams = []
  req.open('GET', '/teams')
  req.responseType = 'json'
  req.send()
  req.onload = function() {
    req.response.forEach(function(i){
      let team = new Team(i)
      allTeams.push(team)
      let teamLi = document.createElement('li')
      teamLi.innerHTML = team.renderTeam()
      teamsUL.appendChild(teamLi)
    })
  }
}
