import grails.util.GrailsUtil
import com.app.*
import com.gl.*
import groovy.sql.Sql
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.codehaus.groovy.grails.commons.ApplicationHolder

class BootStrap {
    def init = { servletContext ->

        def jrl = new Party ( name : 'JRL Endaya Inc.',
            firstName : "JRL",
            middleName : "Endaya",
            lastName : "Inc.",
            tin : "111-111-111-000")
        if(!Party.find(jrl)){
            jrl.save()
            if(jrl.hasErrors()){
                println jrl.errors
            }
        }    
        
        def organization = new AppOrganization(organizationCode:"JRL",
                            organizationName:"JRL Endaya Inc.",
                            organizationType:"Legal Organization",
                            party:Party.find(jrl))
        if(!AppOrganization.find(organization)){
            organization.save()
            if(organization.hasErrors()){
                println organization.errors
            }
        }

        def calcyear = new PeriodType(periodTypeId:"CALENDAR YEAR",
                            periodName:"Calendar Year")
        if(!PeriodType.find(calcyear)){
            calcyear.save()
            if(calcyear.hasErrors()){
                println calcyear.errors
            }
        }

        def acctgpd1 = new AcctgPeriod(acctgPeriodNum:"1",
                    month:"January",
                    fromDate:new Date('01/01/2011'),
                    thruDate:new Date('01/31/2011'),
                    periodTypeId:PeriodType.find(calcyear),
                    year: 2011,
                    organization:AppOrganization.find(organization))

        if(!AcctgPeriod.find(acctgpd1) && PeriodType.find(calcyear) && AppOrganization.find(organization)){
            acctgpd1.save()
            if(acctgpd1.hasErrors()){
                println acctgpd1.errors
            }
        }

        def acctgpd2 = new AcctgPeriod(acctgPeriodNum:"2",
                    month:"February",
                    fromDate:new Date('02/01/2011'),
                    thruDate:new Date('02/29/2011'),
                    periodTypeId:PeriodType.find(calcyear),
                    year: 2011,
                    organization:AppOrganization.find(organization))
        if(!AcctgPeriod.find(acctgpd2) && PeriodType.find(calcyear) && AppOrganization.find(organization)){
            acctgpd2.save()
            if(acctgpd2.hasErrors()){
                println acctgpd2.errors
            }
        }

        def acctgpd3 = new AcctgPeriod(acctgPeriodNum:"3",
                    month:"March",
                    fromDate:new Date('03/01/2011'),
                    thruDate:new Date('03/31/2011'),
                    periodTypeId:PeriodType.find(calcyear),
                    year: 2011,
                    organization:AppOrganization.find(organization))
       if(!AcctgPeriod.find(acctgpd3) && PeriodType.find(calcyear) && AppOrganization.find(organization)){
            acctgpd3.save()
            if(acctgpd3.hasErrors()){
                println acctgpd3.errors
            }
       }

        def acctgpd4 = new AcctgPeriod(acctgPeriodNum:"4",
                    month:"April",
                    fromDate:new Date('04/01/2011'),
                    thruDate:new Date('04/30/2011'),
                    periodTypeId:PeriodType.find(calcyear),
                    year: 2011,
                    organization:AppOrganization.find(organization))
        if(!AcctgPeriod.find(acctgpd4) && PeriodType.find(calcyear) && AppOrganization.find(organization)){
            acctgpd4.save()
            if(acctgpd4.hasErrors()){
                println acctgpd4.errors
            }
        }

        def assets = new GlAccountType(glAccountType:"ASSETS",
                    description:"Assets",
                    glAccountClass : "Asset")
        if(!GlAccountType.find(assets)){
            assets.save()
            if(assets.hasErrors()){
                println assets.errors
            }
        }

        def glAccount1 = new GlAccount(glAccount : "1010-000",
            description : "Cash and Cash in Banks",
            glAccountType : GlAccountType.get(1))
        if(!GlAccount.find(glAccount1)){
            glAccount1.save()
            if(glAccount1.hasErrors()){
                println glAccount1.errors
            }
        }
        
        def glAcctOrg1 = new GlAccountOrganization(glAccount : GlAccount.get(1),
            organization : AppOrganization.get(1),
            startDate : "01/01/2011",
            thruDate : "12/31/2012");
        if(!GlAccountOrganization.find(glAcctOrg1)){
            glAcctOrg1.save();
            if(glAcctOrg1.hasErrors()){
                println glAcctOrg1.errors
            }
        }

        def glAccount2 = new GlAccount(glAccount : "1010-001",
            description : "Petty Cash Fund",
            glAccountType : GlAccountType.get(1))
        if(!GlAccount.find(glAccount2)){
            glAccount2.save()
            if(glAccount2.hasErrors()){
                println glAccount2.errors
            }
        }
        
        def glAcctOrg2 = new GlAccountOrganization(glAccount : GlAccount.get(2),
            organization : AppOrganization.get(1),
            startDate : "01/01/2011",
            thruDate : "12/31/2012");
        if(!GlAccountOrganization.find(glAcctOrg2)){
            glAcctOrg2.save();
            if(glAcctOrg2.hasErrors()){
                println glAcctOrg2.errors
            }
        }

        def glAccount3 = new GlAccount(glAccount : "1011-001",
            description : "Cash",
            glAccountType : GlAccountType.get(1),
            glAccountClass : "Asset")
        if(!GlAccount.find(glAccount3)){
            glAccount3.save()
            if(glAccount3.hasErrors()){
                println glAccount3.errors
            }
        }

        def glAcctOrg3 = new GlAccountOrganization(glAccount : GlAccount.get(3),
            organization : AppOrganization.get(1),
            startDate : "01/01/2011",
            thruDate : "12/31/2012");
        if(!GlAccountOrganization.find(glAcctOrg3)){
            glAcctOrg3.save();
            if(glAcctOrg3.hasErrors()){
                println glAcctOrg3.errors
            }
        }

        def acctgTransType = new AcctgTransType(
                acctgTransCode : 'JV',
                acctgTransName : 'Journal Voucher'
            )
        if(!AcctgTransType.find(acctgTransType)){
            acctgTransType.save();
            if(acctgTransType.hasErrors()){
                println acctgTransType.errors
            }
        }

    }
    def destroy = {
    }
}
