package jrl

class AccessFilters {

    def filters = {
        all(controller:'*', action:'(create|edit|update|delete|save|list)') {
            before = {
                if(!session.user){
                    redirect(uri:"/")
                    return false
                }
            }
            after = {

            }
            afterView = {
                    
            }
        }
    }
    
}
