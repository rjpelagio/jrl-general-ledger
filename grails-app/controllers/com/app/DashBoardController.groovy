package com.app

class DashBoardController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def beforeInterceptor = [action:this.&auth]

    def auth() {
        if(!session.user) {
            redirect(uri:"/")
            return false
        }
    }

    def index = {
        redirect(action: "dashboard", params: params)
    }


    def list = {
        flash.message = "Hello ${session.party.name}!"
    }

}
