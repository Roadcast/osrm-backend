@routing @bicycle @mode
Feature: Bike - Mode flag

	Background:
		Given the profile "bicycle"

    Scenario: Bike - Mode when using a ferry
    	Given the node map
    	 | a | b |   |
    	 |   | c | d |

    	And the ways
    	 | nodes | highway | route | duration |
    	 | ab    | primary |       |          |
    	 | bc    |         | ferry | 0:01     |
    	 | cd    | primary |       |          |

    	When I route I should get
    	 | from | to | route    | turns                       | modes                 |
    	 | a    | d  | ab,bc,cd | head,right,left,destination | cycling,ferry,cycling |
    	 | d    | a  | cd,bc,ab | head,right,left,destination | cycling,ferry,cycling |
    	 | c    | a  | bc,ab    | head,left,destination       | ferry,cycling         |
    	 | d    | b  | cd,bc    | head,right,destination      | cycling,ferry         |
    	 | a    | c  | ab,bc    | head,right,destination      | cycling,ferry         |
    	 | b    | d  | bc,cd    | head,left,destination       | ferry,cycling         |

     Scenario: Bike - Mode when using a train
     	Given the node map
     	 | a | b |   |
     	 |   | c | d |

     	And the ways
     	 | nodes | highway | railway | bicycle |
     	 | ab    | primary |         |         |
     	 | bc    |         | train   | yes     |
     	 | cd    | primary |         |         |

     	When I route I should get
     	 | from | to | route    | turns                       | modes                 |
     	 | a    | d  | ab,bc,cd | head,right,left,destination | cycling,train,cycling |
     	 | d    | a  | cd,bc,ab | head,right,left,destination | cycling,train,cycling |
     	 | c    | a  | bc,ab    | head,left,destination       | train,cycling         |
     	 | d    | b  | cd,bc    | head,right,destination      | cycling,train         |
     	 | a    | c  | ab,bc    | head,right,destination      | cycling,train         |
     	 | b    | d  | bc,cd    | head,left,destination       | train,cycling         |

     @mokobreview
     Scenario: Bike - Mode when pushing bike against oneways
     	Given the node map
     	 | a | b |   |
     	 |   | c | d |

     	And the ways
     	 | nodes | highway | oneway |
     	 | ab    | primary |        |
     	 | bc    | primary | yes    |
     	 | cd    | primary |        |

     	When I route I should get
     	 | from | to | route    | turns                                      | modes                        |
     	 | a    | d  | ab,bc,cd | head,right,left,destination                | cycling,cycling,cycling      |
     	 | d    | a  | cd,bc,ab | head,right,left,destination                | cycling,pushing bike,cycling |
     	 | c    | a  | bc,ab    | head,left,destination                      | pushing bike,cycling         |
     	 | d    | b  | cd,bc    | head,right,destination                     | cycling,pushing bike         |
     	 | a    | c  | ab,bc    | head,right,destination                     | cycling,cycling              |
     	 | b    | d  | bc,cd    | head,left,destination                      | cycling,cycling              |

     Scenario: Bike - Mode when pushing on pedestrain streets
     	Given the node map
     	 | a | b |   |
     	 |   | c | d |

     	And the ways
     	 | nodes | highway    |
     	 | ab    | primary    |
     	 | bc    | pedestrian |
     	 | cd    | primary    |

     	When I route I should get
     	 | from | to | route    | turns                       | modes                        |
     	 | a    | d  | ab,bc,cd | head,right,left,destination | cycling,pushing bike,cycling |
     	 | d    | a  | cd,bc,ab | head,right,left,destination | cycling,pushing bike,cycling |
     	 | c    | a  | bc,ab    | head,left,destination       | pushing bike,cycling         |
     	 | d    | b  | cd,bc    | head,right,destination      | cycling,pushing bike         |
     	 | a    | c  | ab,bc    | head,right,destination      | cycling,pushing bike         |
     	 | b    | d  | bc,cd    | head,left,destination       | pushing bike,cycling         |

     Scenario: Bike - Mode when pushing on pedestrain areas
     	Given the node map
     	 | a | b |   |   |
     	 |   | c | d | f |

     	And the ways
     	 | nodes | highway    | area |
     	 | ab    | primary    |      |
     	 | bcd   | pedestrian | yes  |
     	 | df    | primary    |      |

     	When I route I should get
     	 | from | to | route     | modes |
     	 | a    | f  | ab,bcd,df | cycling,pushing bike,cycling |
     	 | f    | a  | df,bcd,ab | cycling,pushing bike,cycling |
     	 | d    | a  | bcd,ab    | pushing bike,cycling         |
     	 | f    | b  | df,bcd    | cycling,pushing bike         |
     	 | a    | d  | ab,bcd    | cycling,pushing bike         |
     	 | b    | f  | bcd,df    | pushing bike,cycling         |

     Scenario: Bike - Mode when pushing on steps
     	Given the node map
     	 | a | b |   |   |
     	 |   | c | d | f |

     	And the ways
    	 | nodes | highway |
    	 | ab    | primary |
    	 | bc    | steps   |
    	 | cd    | primary |

     	When I route I should get
    	 | from | to | route    | turns                       | modes                        |
    	 | a    | d  | ab,bc,cd | head,right,left,destination | cycling,pushing bike,cycling |
    	 | d    | a  | cd,bc,ab | head,right,left,destination | cycling,pushing bike,cycling |
    	 | c    | a  | bc,ab    | head,left,destination       | pushing bike,cycling         |
    	 | d    | b  | cd,bc    | head,right,destination      | cycling,pushing bike         |
    	 | a    | c  | ab,bc    | head,right,destination      | cycling,pushing bike         |
    	 | b    | d  | bc,cd    | head,left,destination       | pushing bike,cycling         |

     Scenario: Bike - Mode when bicycle=dismount
     	Given the node map
     	 | a | b |   |   |
     	 |   | c | d | f |

     	And the ways
    	 | nodes | highway | bicycle  |
    	 | ab    | primary |          |
    	 | bc    | primary | dismount |
    	 | cd    | primary |          |

     	When I route I should get
    	 | from | to | route    | turns                       | modes                        |
    	 | a    | d  | ab,bc,cd | head,right,left,destination | cycling,pushing bike,cycling |
    	 | d    | a  | cd,bc,ab | head,right,left,destination | cycling,pushing bike,cycling |
    	 | c    | a  | bc,ab    | head,left,destination       | pushing bike,cycling         |
    	 | d    | b  | cd,bc    | head,right,destination      | cycling,pushing bike         |
    	 | a    | c  | ab,bc    | head,right,destination      | cycling,pushing bike         |
         | b    | d  | bc,cd    | head,left,destination       | pushing bike,cycling         |

    Scenario: Bicycle - Modes when starting on forward oneway
        Given the node map
         | a | b |

        And the ways
         | nodes | oneway |
         | ab    | yes    |

        When I route I should get
         | from | to | route | modes            |
         | a    | b  | ab    | cycling          |
         | b    | a  | ab    | pushing bike     |

    Scenario: Bicycle - Modes when starting on reverse oneway
        Given the node map
         | a | b |

        And the ways
         | nodes | oneway |
         | ab    | -1     |

        When I route I should get
         | from | to | route | modes        |
         | a    | b  | ab    | pushing bike |
         | b    | a  | ab    | cycling      |
