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
