App.world = App.cable.subscriptions.create("WorldChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
      // Called when there's incoming data on the websocket for this channel
      // alert(data['message']);
      // var message = document.createElement('div');
      // message.className = "message";
      // var p = document.createElement('p');
      // p.innerHTML = data['message'];
      // message.appendChild(p);
      // document.getElementById('messages').appendChild(message);
      term.echo(data['message']);
      // window.scrollTo(0,document.body.scrollHeight);
  },

  send_message: function(message) {
      return this.perform('send_message', {message: message});
  }
});

document.addEventListener('turbolinks:load', function() {
    // Set background color on the webclient
    document.body.style.background = "#0a0a0a";
    // Create the Jquery Terminal
    term = $('#terminal').terminal(function (command) {
        App.world.send_message(command);
    }, {prompt: '> ', greetings:
    '██████╗  █████╗ ██████╗ ██╗  ██╗    ███████╗██╗     ███████╗' + '\n' +
    '██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝    ██╔════╝██║     ██╔════╝' + '\n' +
    '██║  ██║███████║██████╔╝█████╔╝     █████╗  ██║     █████╗' + '\n' +
    '██║  ██║██╔══██║██╔══██╗██╔═██╗     ██╔══╝  ██║     ██╔══╝' + '\n' +
    '██████╔╝██║  ██║██║  ██║██║  ██╗    ███████╗███████╗██║' + '\n' +
    '╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚══════╝╚══════╝╚═╝' + '\n' +
    'A MUD framework by @sevensidedmarble               v. 0.0.1'
    });
});