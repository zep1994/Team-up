class Team {
  constructor(attr) {
    this.id = attr.id
    this.name = attr.name
    this.type_player = attr.type_player
    this.role = attr.role
    this.quote = attr.quote
    this.players = attr.players
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
    moreData.innerHTML = '<br><h3>Additional Information for '+team.name+'</h3><p><strong>Role: </strong>'+team.role+', <strong>Note: </strong>'+team.quote+'</p><a href="/teams/'+team.id+'">Manage Team</a>'
    playerUL = document.createElement('ul')
    moreData.appendChild(playerUL)

    playerLink = document.createElement('a')
    playerLink.innerHTML = '<a href="/assignments">Assignments</a>'

    if (team.players.length > 0) {
      team.players.forEach(function(player) {
        playerLi = document.createElement('li')
        playerLi.innerHTML = '<li><strong>Players: </strong>' + player.name + '</li>'
        playerUL.appendChild(playerLi)
      })
      moreData.appendChild(playerLink)
    } else {
      playerLi = document.createElement('li')
      playerLi.innerHTML = '<li><strong>There are no players currently on this team</strong></li>'
      playerLi.appendChild(playerLi)
      moreData.appendChild(playerLink)
    }
  }
}

$(() => {
  function Assignment(data) {
    this.id = data.id;
    this.name = data.name;
    this.team_id = data.team_id
    this.player_id = data.player_id
  }

  Assignment.prototype.postAssignment = function() {
    $("#add-assignment").val("");
    var ol = $("div.assignments ol")
    ol.append("<li class='assignment'>" + this.name + "</li>");
  }

  $("form#new_assignment").submit(function(e){
    $.post(this.action, $(this).serialize(),
      function(response){
        var assignment = new Assignment(response);
        assignment.postAssignment();
        $('input:submit').attr('disabled', false)
      }, "json");
    e.preventDefault();
  })
})
