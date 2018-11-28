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

function teamData(team_id) {
  let moreData = document.querySelector('#moreData')
  const req = new XMLHttpRequest()
  const requestUrl = "/teams/"+`${team_id}`
  req.open('GET', requestUrl)
  req.responseType = 'json'
  req.send()
  req.onload = function() {
    let team = new Team(req.response)
    moreData.innerHTML = '<br><h3>Additional Information for '+team.name+'</h3><p><strong>Role: </strong>'+team.role+', <strong>Note: </strong>'+team.quote+'</p><a href="/teams/'+team.id+'">Manage Team</a>';
  }
}
