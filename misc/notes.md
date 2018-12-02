[]<li>Current assignment(s):<br /><br />
    <% if @player.assignments %>
        <% @player.assignments.each do |a| %>
            <%=  a.name %><br />
        <% end %>
    <% end %></li>

[]    if @assignment.save
      flash[:success] = "Saved!"
    else
      flash[:error] = "error"
    end

    def create
      if auth
        @player = Player.find_or_create_by(uid: auth['uid']) do |u|
          u.name = auth['info']['name']
          u.email = auth['info']['email']
          u.password = auth['uid']
        end
        @player.save
        session[:player_id] = @player.id
      else
        player = Player.find_by(name: params[:player][:name])
        player = player.try(:authenticate, params[:player][:password])
        return redirect_to(controller: 'sessions', action: 'new') unless player
        session[:user_id] = player.id
        @player = player
      end
      redirect_to player_path(@player)
    end

    def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |player|
     player.email = auth.info.email
     player.password = Devise.friendly_token[0,20]
     player.name = auth.info.name  
   end
 end


[]    <%= link_to "#{p.name}", team_assignment_path(@team, a) %>
    <% a = Assignment.find_by(:team_id => @team.id, :player_id => p.id) %>


    <p>Create Assignment?</p>
    <%= f.fields_for :assignments, @team.assignments.build do |a| %>

        <p>Select a team member:
        <%= select_tag 'team[assignments_attributes][0][player_id]', content_tag(:option,'select one...',:value=>"")+options_from_collection_for_select(Player.all, :id, :name) %></p>

        <%= a.hidden_field :team_id, value: @team.id %>

        <%= a.label :name, "Assignment Name" %>
        <%= a.text_field :name %><br>
        <%= a.label :description %>
        <%= a.text_field :description %>
    <% end %>


    #1st you retrieve the team thanks to params[:team_id]
    team = Team.find(params[:team_id])
    #2nd you get all the assignments of this post
    @assignments = team.assignments



Both paths /team/team_id/assignments
&&
/assignments

add error message for the signup

README


#add flash message?
redirect_to assignments_path(@assignment), notice: "Successfully Created."


(function(){

  var $assignments = $('.assignments')
  var $name = $('#name')
  var $description = $('#description')
  var $assignment_team_id = $('#assignment_team_id')
  var $assignment_player_id = $('#assignment_player_id')


  $('#add-assignment').on('click', function(event) {
    var assignment = {
      name: $name.val(),
      description: $description.val(),
      team_id: $assignment_team_id.val(),
      player_id: $assignment_player_id.val()
  }

  $.ajax({
    type: 'POST',
    url: this.action
    data: assignment,
    success: function(newAssignment){
      $assignments.append('<li>name: '+ newAssignment.name +', description: '+ newAssignment.description + ', team: '+ newAssignment.assignment_team_id + ', player: '+ newAssignment.assignment_player_id + '</li>')
    }
  })
  event.preventDefault()
  })
})
