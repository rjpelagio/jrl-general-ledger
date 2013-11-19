package jrl

class FooterTagLib {
    def thisYear = {
        out << new Date().format("yyyy")
    }
}
