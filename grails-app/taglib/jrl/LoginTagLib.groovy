package jrl

import com.app.Party

class LoginTagLib {
    def loginControl = {
        if(request.getSession(false) && session.user){
            out << "Hello "
            out << """${link(action:"changePassword",
                    controller:"appUser"){"${Party.find(session.user.party).firstName} ${Party.find(session.user.party).lastName}"}}"""
            out << " | ${session.organization.organizationName} | "
            out << """${link(action:"logout",
                    controller:"appUser"){"Logout"}}"""
        } else {
            out << """${link(action:"login",
                    controller:"appUser"){"Login"}}"""
        }
    }
}