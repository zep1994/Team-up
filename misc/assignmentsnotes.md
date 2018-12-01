//assignment.js
class Assignment {
  constructor(attrjson){
    this.name = attrjson.name
    this.description = attrjson.description
    this.team_id = attrjson.team_id
    this.player_id = attrjson.player_id
  }
}

function postAssignment(team_id) {
  let assignmentForm = document.querySelector("form")
  if (assignmentForm) {
    assignmentForm.onsubmit = function(event){
      event.preventDefault()

      const xhr = new XMLHttpRequest()
      const url = 'teams/${team_id}'
      let token = document.querySelector('meta[name="csrf-token"]').content
      let newAssignment = {
        name: document.querySelector("#assignment_name").value
        description: document.querySelector("#assignment_description").value
        team_id: document.querySelector("#assignment_team_id").value
        player_id: document.querySelector("#assignment_player_id").value
      }
      xhr.responseType = 'json'
      xhr.onreadystatechange = () => {
        if (xhr.readyState === XMLHttpRequest.DONE) {
          let assignmentList = document.querySelector("#assignmentList")
          let newAction = document.createElement('li')
          newAction.innerHTML = "<li>"+xhr.response.player.role+" "+xhr.response.player.name+ ' is <a href="/teams/'+ xhr.response.team.id + '/assignments/' + xhr.response.id +'">' + 'assigned</a> to the ' + xhr.response.team.name + '.</li>'
          assignmentList.appendChild(newAction)
        }
      }
      xhr.open('POST', url)
      xhr.setRequestHeader("x-csrf-token", token);
      xhr.setRequestHeader("Accept", "application/json");
      xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
      xhr.send(JSON.stringify(newAssignment));
      assignmentForm.reset();
    }
  }
}

window.onload = postAssignment()

//teams/show
<script>window.onload = postAssignment();</script>
