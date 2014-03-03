package jrl

import com.app.Party

class LoginTagLib {
    def loginControl = {
        if(request.getSession(false) && session.user){
            out << "Hello "
            out << """${link(action:"changePassword",
                    controller:"appUser"){"${session.party.name}"}}"""
            out << " | ${session.organization.organizationName} | "
            out << """${link(action:"logout",
                    controller:"appUser"){"Logout"}}"""
        } else {
            out << """${link(action:"login",
                    controller:"appUser"){"Login"}}"""
        }
    }
}