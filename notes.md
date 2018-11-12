<li>Current assignment(s):<br /><br />
    <% if @player.assignments %>
        <% @player.assignments.each do |a| %>
            <%=  a.name %><br />
        <% end %>
    <% end %></li>
