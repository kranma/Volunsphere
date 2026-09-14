workspace "VolunSphere" {

    model {

        volunteer = person "Volunteer" {
            description "Searches for volunteering opportunities and applies for them"
        }

        ministry = softwareSystem "BMASGPK" {
            description "Ministry accessing reports, statistics and governance functions"
        }

        gaiax = softwareSystem "Gaia-X Trust Framework" {
            description "Trust framework for organisation onboarding and credential verification"
            tags "outofscope"
        }

        eudi = softwareSystem "EUDI Wallet Ecosystem" {
            description "Wallet infrastructure for identities and credentials"
            tags "outofscope"
        }

        esco = softwareSystem "ESCO / Competence Framework" {
            description "Competence and skill vocabulary"
            tags "outofscope"
        }

        volunsphere = softwareSystem "Plattform Digitaler FWP" {

            frontend = container "Web Frontend" {
                description "Marketplace and user portal"

                marketplace = component "Marketplace Service" {
                description "Search, discovery and requesting of volunteering opportunities"
            }

                community = component "Community Service" {
                description "Messaging and community functions"
            }

                signin = component "Sign-In Service" {
                    description "User authentication and authorization"
                }

                reporting = component "Reporting Service" {
                    description "Aggregates and visualizes data for governance and statistics"
                }
            }

            database = container "Database" {
                description "Stores user data, opportunities and registrations"
            }
            backend = container "Backend Service" {
                description "Service and API coordinationand for the frontend"

                
                identity = component "Identity Service" {
                    description "Authentication and credential verification of organisations"
                }

                core = component "Core Backend" {
                    description "Communicates with other connectors, prepares metadata for the Frontend, forwards requests to Connectors"
                }
            }


            connector = container "EDC Connector" {
                description "Connector for identity, policy and metadata exchange, crawls metadata from participating organizations"

                controlplane = component "Control Plane" {
                description "Manages data exchange and policy enforcement"
            }
                dataplane = component "Data Plane" {
                description "Handles data transfer and transformation"
            }
            }



            audit = container "Audit Log" {
                description "Stores audit and governance events"
            }
        }

        org1 = softwareSystem "Participating Organization A" {


            
            connector1 = container "EDC Connector" {
                description "Connector for identity, policy and metadata exchange"

                controlplane1 = component "Control Plane" {
                description "Manages data exchange and policy enforcement"
            }
                dataplane1 = component "Data Plane" {
                description "Handles data transfer and transformation"
            }
            }
            frontend1 = container "Organization Frontend" {
                description "Optional UI for analythics"

                login1 = component "Login Service" {
                    description "Authenticates and authorizes users"
                }
                catalog1 = component "UI" {
                    description "Interactive UI for managing requests of volunteers"
                }
                reporting1 = component "Reporting Service" {
                    description "Aggregates and visualizes data for governance and statistics"
                }
            
            
            }

            backend1 = container "Backend Service" {
                description "Prepares and manages volunteer requests"
            }

            database1 = container "Local Database" {
                description "Source of Truth for opportunities and volunteer requests"
            }

            wallet1 = container "Wallet" {

                vc1 = component "Verifiable Credentials"

                did1 = component "DID Keypair"
            }

            semantic1 = container "Semantic Layer" {

                esco_map1 = component "ESCO Mapping"

                ontology_map1 = component "Ontology Mapping"

                shacl1 = component "SHACL Validation"
            }
        }

    org2 = softwareSystem "Participating Organization B" {


            
            connector2 = container "EDC Connector" {
                description "Connector for identity, policy and metadata exchange"

                controlplane2 = component "Control Plane" {
                description "Manages data exchange and policy enforcement"
            }
                dataplane2 = component "Data Plane" {
                description "Handles data transfer and transformation"
            }
            }

            frontend2 = container "Organization Frontend" {
                description "Optional UI for analythics"

                login2 = component "Login Service" {
                    description "Authenticates and authorizes users"
                }
                catalog2 = component "UI" {
                    description "Interactive UI for managing requests of volunteers"
                }
                reporting2 = component "Reporting Service" {
                    description "Aggregates and visualizes data for governance and statistics"
                }
            
            
            }

            backend2 = container "Backend Service" {
                description "Prepares and manages volunteer requests"
            }

            database2 = container "Local Database" {
                description "Source of Truth for opportunities and volunteer requests"
            }

            wallet2 = container "Wallet" {

                vc2 = component "Verifiable Credentials"

                did2 = component "DID Keypair"
            }

            semantic2 = container "Semantic Layer" {

                esco_map2 = component "ESCO Mapping"

                ontology_map2 = component "Ontology Mapping"

                shacl2 = component "SHACL Validation"
            }
        }
    extopt1 = softwareSystem "External Opportunity System A" {
            description "External source of volunteering opportunities"
            tags "outofscope"
        }

    extopt2 = softwareSystem "External Opportunity System B" {
            description "External source of volunteering opportunities"
            tags "outofscope"
        }
        
        # Relations

        volunteer -> frontend "Searches and applies for opportunities" HTTPS
        volunteer -> eudi "Stores identity and certificates"
        volunteer -> signin "Authenticates and authorizes" HTTPS
        volunteer -> marketplace "Searches and requests opportunities" HTTPS
        volunteer -> community "Chats with in community" HTTPS
        backend -> connector "Connects to federated catalog endpoint"
        backend -> marketplace "Prepares and provides metadata for opportunities"
        signin -> database "Sends and stores registration data of volunteers"
        marketplace -> core "Forwards requests"
        core -> marketplace "Provides metadata for opportunities"
        core -> controlplane "Receives and forwards requests to connector"
        core -> dataplane "Receives and forwards requested data to connector"
        core -> database "Forwards registration data of volunteers for requests"
        ministry -> reporting "Performs and views reports"
        ministry -> signin "Authenticates and authorizes" HTTPS
        ministry -> database "Sends and stores registration data of ministry"
        connector -> connector1 "Crawls metadata" EDC
        connector -> connector2 "Crawls metadata" EDC
        connector1 -> database1 "Accesses opportunities"
        connector2 -> database2 "Accesses opportunities"
        connector1 -> wallet1 "Access organisational credentials"
        connector2 -> wallet2 "Access organisational credentials"
        connector1 -> gaiax "Proves organisational identity, obtains VCs"
        connector2 -> gaiax "Proves organisational identity, obtains VCs"
        semantic1 -> database1 "Provides transformed data"

        semantic2 -> database2 "Provides transformed data"
        semantic1 -> connector1 "Provides JSON-LD assets"
        semantic2 -> connector2 "Provides JSON-LD assets"
        connector1 -> database1 "Stores requests and registrations of volunteers"
        connector2 -> database2 "Stores requests and registrations of volunteers"backend
        backend1 -> database1 "Processes requests and opportunities"
        backend2 -> database2 "Prepares requests and opportunities"
        frontend1 -> backend1 "Shows requests and opportunities"
        frontend2 -> backend2 "Shows requests and opportunities"
        backend -> audit "Writes audit events"
        ontology_map1 -> extopt1 "Matches external opportunities to defined ontology"
        ontology_map2 -> extopt2 "Matches external opportunities to defined ontology"
        shacl1 -> ontology_map1 "Validates transformed opportunities against defined ontology"
        shacl2 -> ontology_map2 "Validates transformed opportunities against defined ontology"
        ontology_map1 -> database1 "Stores transformed opportunities"
        ontology_map2 -> database2 "Stores transformed opportunities"
        ontology_map1 -> esco_map1 "Matches transformed opportunities to defined competences"
        ontology_map2 -> esco_map2 "Matches transformed opportunities to defined competences"
        signin -> audit "Writes authentication events"
        esco -> esco_map1 "Provides skill and competence vocabulary"
        esco -> esco_map2 "Provides skill and competence vocabulary"
    }

    views {

        systemLandscape volunsphere {
            title "VolunSphere System Landscape"
            include *
            autoLayout tb
        }

        container volunsphere {
            title "VolunSphere Platform Containers"
            include *
            autoLayout tb
        }

        container org1 {
            title "Participating Organization"
            include *
            autoLayout tb
        }

        container org2 {
            title "Participating Organization"
            include *
            autoLayout tb
        }

        component frontend {
            title "VolunSphere Frontend Components"
            include *
            autoLayout tb
        }

        component backend {
            title "VolunSphere Backend Components"
            include *
            autoLayout tb
        }
         component connector {
            title "VolunSphere Connector Components"
            include *
            autoLayout tb
         }
         component connector1 {
            title "Participating Organization Connector Components"
            include *
            autoLayout tb
         }
            component connector2 {
                title "Participating Organization Connector Components"
                include *
                autoLayout tb
            }

            component semantic1 {
                title "Participating Organization Semantic Layer Components"
                include *
                autoLayout tb
            }
            component semantic2 {
                title "Participating Organization Semantic Layer Components"
                include *
                autoLayout tb
            }
            component frontend1 {
                title "Participating Organization Frontend Components"
                include *
                autoLayout tb
            }
            component frontend2 {
                title "Participating Organization Frontend Components"
                include *
                autoLayout tb
            }
            component backend1 {
                title "Participating Organization Backend Components"
                include *
                autoLayout tb
            }
            component backend2 {
                title "Participating Organization Backend Components"
                include *
                autoLayout tb
            }
            component database1 {
                title "Participating Organization Database Components"
                include *
                autoLayout tb
            }
            component database2 {
                title "Participating Organization Database Components"
                include *
                autoLayout tb
            }
            component wallet1 {
                title "Participating Organization Wallet Components"
                include *
                autoLayout tb
            }
            component wallet2 {
                title "Participating Organization Wallet Components"
                include *
                autoLayout tb
            }
        
        

        theme default

        styles {

            element "Person" {
                shape Person
            }

            element "Policy" {
                shape Folder
                background #E4080A
            }

            element "outofscope" {
                background #999999
            }

            element "Web Application" {
                shape WebBrowser
            }
        }
    }
}