/** Import controller firstly */
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

    /** Start */
    connect() {
        console.log("En connexion")
        const messages = document.getElementById("messages")
        messages.addEventListener("DOMNodeInserted", this.resetScroll)
        this.resetScroll(messages);
    }

    /** Stop */
    disconnect() {
        console.log("Déconnecté")
    }

    /** Custom function */
    resetScroll() {
        messages.scrollTop = messages.scrollHeight - messages.clientHeight;
    }

}