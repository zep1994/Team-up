$(function () {
	addAssignment();
})



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
	req.onload = function () {
		req.response.forEach(function (i) {
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
	const requestUrl = "/teams/" + `${team_id}`
	req.open('GET', requestUrl)
	req.responseType = 'json'
	req.send()
	req.onload = function () {
		let team = new Team(req.response)
		moreData.innerHTML = '<br><h3>Additional Information for ' + team.name + '</h3><p><strong>Role: </strong>' + team.role + ', <strong>Note: </strong>' + team.quote + '</p><a href="/teams/' + team.id + '">Manage Team</a>'
		playerUL = document.createElement('ul')
		moreData.appendChild(playerUL)

		playerLink = document.createElement('a')
		playerLink.innerHTML = '<a href="/assignments">Assignments</a>'

		if (team.players.length > 0) {
			team.players.forEach(function (player) {
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

class Assignment {
	constructor(attr) {
		//this.id = attr.id
		this.name = attr.name
		this.description = attr.description
		this.team_id = attr.team_id
		this.player_id = attr.player_id

	}
}

Assignment.prototype.postAssignment = function () {
	$("#new_assignment").val("");
	var ol = $("div#assignments ol")
	ol.append("<li class='assignment'>" + this.name + "</li>");
}

function addAssignment() {
	$("button#add_assignment").on('click', function (event) {
		event.preventDefault();
		event.stopImmediatePropagation();
		let player_id = $("select#assignment_player_id").val()
		let name = $("input#assignment_name").val()
		let description = $("input#assignment_description").val()
		let team_id = $("select#assignment_team_id").val()
		let assignment_data = {
			name: name,
			description: description,
			team_id: team_id,
			player_id: player_id
		}

		const assignment_instance = new Assignment(assignment_data)
		console.log("assignment_instance: ", assignment_instance);


		// note the use of a "label" "assignment_instance: " while console.logging, it helps keep clarity in console

		// we now have an instance of Assignment
		// BTW ... we could also have just sent assignment_data straight to createAssignment()
		// but, by using your Assignment class to create an object (instance of Assignment),
		// you gain the advantage of being able to call your custom functions on the instance
		// which we will do after the ajax call next in createAssignment()
		// the custom function you have currenty is: postAssignment() above...

		// so we pass the assignment_instance to createAssignment here....

		createAssignment(assignment_instance)
	})
}



function createAssignment(new_assignment_instance_data) {

	console.log("new_assignment_instance_data: ", new_assignment_instance_data);

	// now that we have data from our form, we want to do 2 things
	// 1. send a post request to save this data to the database
	// 2. put the data onto the DOM, or render a page that shows the added assignment
	//  WITHOUT rerendering the page....

	// we know the URL we want:   /assignments
	// the method is:  "post"
	// the data is: new_assignment_instance_data

	// note: you could also have made this function by adding it to the Assignment prototype
	// Assignment.prototype.createAssignment for example
	// in this case, we'll just make a function

	$.ajax({
		url: '/assignments',
		method: 'post',
		data: { assignment: new_assignment_instance_data }, // this forms assignment_params properly for Rails controller
		cors: 'no-cors',
		success: function (response) {

			console.log("response: ", response);
			$("#assignments").append("<li class='assignment'>" + response.name + "</li>");
			// this is where you might also choose to put the data onto the DOM
			// typically you would separate out this into its own function
			// like you did with 			Assignment.prototype.postAssignment
		}
	})

}
