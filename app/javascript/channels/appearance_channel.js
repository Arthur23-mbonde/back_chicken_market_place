import consumer from "channels/consumer"

let resetFunc;
let timer = 0;

consumer.subscriptions.create("AppearanceChannel", {

  initialized() {},

  connected() {
    // Called when the subscription is ready for use on the server
    // this.perform('online');
    console.log("connected");
    resetFunc = () => this.resetTimer(this.uninstall);
    this.install();
    window.addEventListener("turbo:load", () => this.resetTimer());
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected");
    this.uninsatll();
  },

  rejected() {
    console.log("rejected");
    this.uninstall();
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  },

  online() {
    console.log("online");
    this.perform("online");
  },

  away() {
    console.log("away");
    this.perform("away");
  },

  offline() {
    console.log("offline");
    this.perform("offline");
  },

  uninsatll() {
    const shouldRun = document.getElementById("appearance_channel");
    if (!shouldRun) {
      clearTimeout(timer);
      this.perform("offline");
    }
  },

  install() {
    console.log('Install');
    window.removeEventlistener("load", resetFunc);
    window.removeEventlistener("DOMContenLoaded", resetFunc);
    window.removeEventlistener("click", resetFunc);
    window.removeEventlistener("keydown", resetFunc);

    window.addEventlistener("load", resetFunc);
    window.addEventlistener("DOMContenLoaded", resetFunc);
    window.addEventlistener("click", resetFunc);
    window.addEventlistener("keydown", resetFunc);
    this.resetTimer();
  },

  resetTimer() {
    this.uninstall();
    const shouldRun = document.getElementById("appearance_channel");

    if (!!shouldRun) {
      this.online();
      clearTimeout(timer);
      const timeInSeconds = 5;
      const milliseconds = 1000;
      const timeInMilliseconds = timeInSeconds * milliseconds;

      timer = setTimeout(this.away.bind(this), timeInMilliseconds);
    }
  },

});
