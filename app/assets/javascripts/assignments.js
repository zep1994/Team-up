$(function(){
  $('#new_assignment').on('submit', function(event){
    alert("you clicked")
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
    console.log(data)
    event.preventDefault()

  })
})
