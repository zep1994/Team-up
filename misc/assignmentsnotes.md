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
<%= render 'assignments/form' %>
<script>window.onload = postAssignment();</script>


<br></br>
<p><%= link_to "Edit this assignment", edit_assignment_path(@assignment.id) %></p>
<p><%= link_to "Delete", @assignment, method: :delete, data: { confirm: "Confirm Deleting?" } %></p>


$(function(){
  $('#new_assignment').on('submit', function(event){
    url = this.action
    console.log(url)

    data = {
      'authenticity_token' : $("input[name='authenticity_token']").val(),
      'assignment' : {
        'name' : $("#assignment_name").val(),
        'description' : $("#assignment_description").val(),
        'team' : $("#assignment_team_id").val(),
        'player' : $("#assignment_player_id").val()
      }
    }

    $.ajax({
      type: ($("input[name='_method']").val() || this.method),
      url: this.action,
      data: $(this).serialize(),
      success: function(response) {
        $("#assignment_name").val("");
        $("#assignment_description").val("");
        $("#assignment_team_id").val("");
        $("#assignment_player_id").val("");
        var ul = $("div.align")
      }
    });
    event.preventDefault()

  })
})

, :description, :team_id, :player_id


'description' : $("#assignment_description").val(),
'team' : $("#assignment_team_id").val(),
'player' : $("#assignment_player_id").val()


<strong><%= f.label :description %></strong>
<%= f.text_field :description %><br></br>

<strong><%= f.label :team_id %></strong><br>
<!-- <%= f.collection_check_boxes :team_id, Team.all, :id, :name %><br></br> -->
<%= f.select(:team_id) do %>
    <%= options_from_collection_for_select(Team.all, :id, :name, :selected => @assignment.team_id) %>
<% end %>

<br></br>
<strong><%= f.label :player_id %></strong><br>
<!--<%= f.collection_check_boxes :player_id, Player.all, :id, :name %><br> -->
<%= f.select(:player_id) do %>
    <%= options_from_collection_for_select(Player.all, :id, :name, :selected => @assignment.player_id) %>
<% end %>
