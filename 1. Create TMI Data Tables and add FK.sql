/*==========================================================================================
1. Create TMI Tables
2. Establish Foreign Keys between Tables
3. Run a full SELECT JOIN statement
=========================================================================================*/




/*==========================================================================================
CREATE ALL TMI TABLES
=========================================================================================*/


-- DROP DATABASE Project77;
-- CREATE DATABASE x0807x;
-- USE x0807x;

DROP TABLE IF EXISTS TMI_TRACKS ;
CREATE TABLE TMI_TRACKS ( id Serial , track VARCHAR(255) , tmiorder INT , created TIMESTAMP DEFAULT CURRENT_TIMESTAMP , createdby VARCHAR(255) , updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP , updatedby VARCHAR(255) );
INSERT INTO TMI_TRACKS ( track , tmiorder , createdby ) VALUES ( 'Communication'  , '1' , 'bulk' );
INSERT INTO TMI_TRACKS ( track , tmiorder , createdby ) VALUES ( 'Leadership'  , '2' , 'bulk' );
INSERT INTO TMI_TRACKS ( track , tmiorder , createdby ) VALUES ( 'No Track'  , '3' , 'bulk' );
SELECT * FROM TMI_TRACKS ;

DROP TABLE IF EXISTS TMI_QUALIFICATIONS ;
CREATE TABLE TMI_QUALIFICATIONS ( id Serial , qualification VARCHAR(255) , tracksID bigint(40) unsigned , tmiorder INT , created TIMESTAMP DEFAULT CURRENT_TIMESTAMP , createdby VARCHAR(255) , updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP , updatedby VARCHAR(255) );
INSERT INTO TMI_QUALIFICATIONS ( qualification , tracksID , tmiorder , createdby ) VALUES ( 'Competent Communicator'  , '1' , '1' , 'bulk' );
INSERT INTO TMI_QUALIFICATIONS ( qualification , tracksID , tmiorder , createdby ) VALUES ( 'Advanced Communicator Bronze'  , '1' , '2' , 'bulk' );
INSERT INTO TMI_QUALIFICATIONS ( qualification , tracksID , tmiorder , createdby ) VALUES ( 'Advanced Communicator Silver'  , '1' , '3' , 'bulk' );
INSERT INTO TMI_QUALIFICATIONS ( qualification , tracksID , tmiorder , createdby ) VALUES ( 'Advanced Communicator Gold'  , '1' , '4' , 'bulk' );
INSERT INTO TMI_QUALIFICATIONS ( qualification , tracksID , tmiorder , createdby ) VALUES ( 'Competent Leader'  , '2' , '5' , 'bulk' );
INSERT INTO TMI_QUALIFICATIONS ( qualification , tracksID , tmiorder , createdby ) VALUES ( 'Advanced Leader Bronze'  , '2' , '6' , 'bulk' );
INSERT INTO TMI_QUALIFICATIONS ( qualification , tracksID , tmiorder , createdby ) VALUES ( 'Advanced Leader Silver'  , '2' , '7' , 'bulk' );
INSERT INTO TMI_QUALIFICATIONS ( qualification , tracksID , tmiorder , createdby ) VALUES ( 'Distingushed Toastmaster'  , '2' , '8' , 'bulk' );
INSERT INTO TMI_QUALIFICATIONS ( qualification , tracksID , tmiorder , createdby ) VALUES ( 'No qualification'  , '3' , '9' , 'bulk' );
SELECT * FROM TMI_QUALIFICATIONS ;


DROP TABLE IF EXISTS TMI_QUALS_MANUALGROUPS ;
CREATE TABLE TMI_QUALS_MANUALGROUPS ( id Serial , qualificationID bigint(40) unsigned , manual_groupID bigint(40) unsigned , tmiorder INT , start_date DATE , end_date DATE , created TIMESTAMP DEFAULT CURRENT_TIMESTAMP , createdby VARCHAR(255) , updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP , updatedby VARCHAR(255) );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '1'  , '1' , '1' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '2'  , '2' , '2' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '3'  , '2' , '3' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '3'  , '3' , '4' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '3'  , '4' , '5' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '4'  , '2' , '6' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '4'  , '5' , '7' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '4'  , '6' , '8' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '5'  , '7' , '9' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '6'  , '4' , '10' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '6'  , '8' , '11' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '7'  , '9' , '12' , 'bulk' );
INSERT INTO TMI_QUALS_MANUALGROUPS ( qualificationID , manual_groupID , tmiorder , createdby ) VALUES ( '9'  , '10' , '13' , 'bulk' );
SELECT * FROM TMI_QUALS_MANUALGROUPS ;


DROP TABLE IF EXISTS TMI_MANUAL_GROUPS ;
CREATE TABLE TMI_MANUAL_GROUPS ( id Serial , manual_group VARCHAR(255) , qualificationsID bigint(40) unsigned , tmiorder INT , created TIMESTAMP DEFAULT CURRENT_TIMESTAMP , createdby VARCHAR(255) , updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP , updatedby VARCHAR(255) );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'Competent Communicator'  , '1' , '1' , 'bulk' );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'Advanced Communicator'  , '2' , '2' , 'bulk' );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'Better Speaker Series'  , '3' , '3' , 'bulk' );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'Successful Club Series'  , '3' , '4' , 'bulk' );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'Success Communication'  , '4' , '5' , 'bulk' );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'Success Leadership'  , '4' , '6' , 'bulk' );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'Competent Leader'  , '5' , '7' , 'bulk' );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'Leadership Excellence Series'  , '6' , '8' , 'bulk' );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'High Performance Leadership Program'  , '7' , '9' , 'bulk' );
INSERT INTO TMI_MANUAL_GROUPS ( manual_group , qualificationsID , tmiorder , createdby ) VALUES ( 'No Manual Group'  , '9' , '10' , 'bulk' );
SELECT * FROM TMI_MANUAL_GROUPS ;


DROP TABLE IF EXISTS TMI_MANUALS ;
CREATE TABLE TMI_MANUALS ( id Serial , manual VARCHAR(255) , manual_code VARCHAR(255) , manual_groupsID bigint(40) unsigned , tmiorder INT , created TIMESTAMP DEFAULT CURRENT_TIMESTAMP , createdby VARCHAR(255) , updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP , updatedby VARCHAR(255) );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Competent Communicator'  , '225' , '1' , '1' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Communicating On Video'  , '226J' , '2' , '11' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Facilitating Discussion'  , '226D' , '2' , '5' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Humorous Speeches'  , '226O' , '2' , '16' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Interpersonal Communication'  , '226M' , '2' , '14' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Interpretive Reading'  , '226L' , '2' , '13' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Persuasive Speaking'  , '226I' , '2' , '10' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Public Relations'  , '226C' , '2' , '4' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Speaking to Inform'  , '226B' , '2' , '3' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Special Occasion Speeches'  , '226N' , '2' , '15' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Specialty Speeches'  , '226E' , '2' , '6' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Speeches by Management'  , '226F' , '2' , '7' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Storytelling'  , '226K' , '2' , '12' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Technical Presentations'  , '226H' , '2' , '9' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'The Entertaining Speaker'  , '226A' , '2' , '2' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'The Professional Speaker'  , '226G' , '2' , '8' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Beginning Your Speech'  , '270' , '3' , '17' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Concluding Your Speech'  , '271' , '3' , '18' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Controlling Your Fear'  , '272' , '3' , '19' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Creating An Introduction'  , '277' , '3' , '24' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Impromptu Speaking'  , '273' , '3' , '20' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Know Your Audience'  , '275' , '3' , '22' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Organizing Your Speech'  , '276' , '3' , '23' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Preparation And Practice'  , '278' , '3' , '25' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Selecting Your Topic'  , '274' , '3' , '21' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Using Body Language'  , '279' , '3' , '26' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Closing The Sale'  , '293' , '4' , '30' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Creating The Best Club Climate'  , '294' , '4' , '31' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Evaluate To Motivate'  , '292' , '4' , '29' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Finding New Members For Your Club'  , '291' , '4' , '28' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Going Beyond Our Club'  , '298' , '4' , '35' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'How To Be A Distinguished Club'  , '299' , '4' , '36' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Keeping The Commitment'  , '297' , '4' , '34' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Meeting Roles And Responsibilities'  , '295' , '4' , '32' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Mentoring'  , '296' , '4' , '33' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Moments Of Truth'  , '290' , '4' , '27' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'The Toastmasters Educational Program'  , '300' , '4' , '37' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Building Your Thinking Power, Part I: Mental Flexibility'  , '253' , '5' , '41' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Building Your Thinking Power, Part II: The Power Of Ideas'  , '254' , '5' , '42' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'From Speaker To Trainer'  , '257' , '5' , '43' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'How To Listen Effectively'  , '242' , '5' , '39' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Speechcraft Starter Kit'  , '205' , '5' , '38' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'The Art Of Effective Evaluation'  , '251' , '5' , '40' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'How To Conduct Productive Meetings'  , '236' , '6' , '44' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Improving Your Management Skills'  , '259' , '6' , '49' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Leadership, Part I: Characteristics Of Effective Leaders'  , '255' , '6' , '46' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Leadership, Part II: Developing Your Leadership Skills'  , '256' , '6' , '47' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Leadership, Part III: Working In The Team Environment'  , '258' , '6' , '48' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Parliamentary Procedure In Action'  , '237' , '6' , '45' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Competent Leader'  , '265' , '7' , '50' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Building A Team'  , '316' , '8' , '57' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Delegate To Empower'  , '315' , '8' , '56' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Developing A Mission'  , '312' , '8' , '53' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Giving Effective Feedback'  , '317' , '8' , '58' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Goal Setting And Planning'  , '314' , '8' , '55' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Motivating People'  , '265' , '8' , '51' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Resolving Conflict'  , '321' , '8' , '61' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Service And Leadership'  , '320' , '8' , '60' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'The Leader as a Coach'  , '318' , '8' , '59' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'The Visionary Leader'  , '311' , '8' , '52' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'Values and Leadership'  , '313' , '8' , '54' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'High Performance Leadership Program'  , '262' , '9' , '62' , 'bulk' );
INSERT INTO TMI_MANUALS ( manual , manual_code , manual_groupsID , tmiorder , createdby ) VALUES ( 'No Manual'  , '0' , '10' , '63' , 'bulk' );
SELECT * FROM TMI_MANUALS ;

DROP TABLE IF EXISTS TMI_PROJECTS ;
CREATE TABLE TMI_PROJECTS ( id Serial , project VARCHAR(255) , manualsID bigint(40) unsigned , rolesID bigint(40) unsigned , tmiorder DECIMAL(5,2) , created TIMESTAMP DEFAULT CURRENT_TIMESTAMP , createdby VARCHAR(255) , updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP , updatedby VARCHAR(255) );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 1: The Ice Breaker'  , '1' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 2: Organise Your Speech'  , '1' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 3: Get to the Point'  , '1' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 4: How To Say It'  , '1' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 5: Your Body Speaks'  , '1' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 6: Vocal Variety'  , '1' , '1' , '6' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 7: Research Your Topic'  , '1' , '1' , '7' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 8: Get Comfortable with Visual Aids'  , '1' , '1' , '8' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 9: Persuade with Power'  , '1' , '1' , '9' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Project 10: Inspire Your Audience'  , '1' , '1' , '10' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Instruction on the Internet'  , '2' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Straight Talk'  , '2' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Press Conference'  , '2' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Talk Show'  , '2' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'When Youre the Host'  , '2' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Handling Challenging Situations'  , '3' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Reaching a Consensus'  , '3' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Brainstorming Session'  , '3' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Panel Moderator'  , '3' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Problem-Solving Discussion'  , '3' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Keep Them Laughing'  , '4' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Leave Them with a Smile'  , '4' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Make Them Laugh'  , '4' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Humorous Speech'  , '4' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Warm Up Your Audience'  , '4' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Asserting Yourself Effectively'  , '5' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Conversing with Ease'  , '5' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Diffusing Verbal Criticism'  , '5' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Coach'  , '5' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Successful Negotiator'  , '5' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Interpreting Poetry'  , '6' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Read a Story'  , '6' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Monodrama'  , '6' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Oratorical Speech'  , '6' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Play'  , '6' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Addressing the Opposition'  , '7' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Conquering the Cold Call'  , '7' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Effective Salesperson'  , '7' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Persuasive Leader'  , '7' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Winning Proposal'  , '7' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Speaking Under Fire'  , '8' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Crisis Management Speech'  , '8' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Goodwill Speech'  , '8' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Persuasive Approach'  , '8' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Radio Talk Show'  , '8' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'A Fact-Finding Report'  , '9' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Resources for Informing'  , '9' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Abstract Concept'  , '9' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Demonstration Talk'  , '9' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Speech to Inform'  , '9' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Accepting an Award'  , '10' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Mastering the Toast'  , '10' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Presenting an Award'  , '10' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Speaking in Praise'  , '10' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Roast'  , '10' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Introduce the Speaker'  , '11' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Read Out Loud'  , '11' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Sell a Product'  , '11' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Speak Off the Cuff'  , '11' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Uplift the Spirit'  , '11' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Confrontation: The Adversary Relationship'  , '12' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Manage and Motivate'  , '12' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Briefing'  , '12' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Status Report'  , '12' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Technical Speech'  , '12' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Bringing History to Life'  , '13' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Lets Get Personal'  , '13' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Folk Tale'  , '13' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Moral of the Story'  , '13' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Touching Story'  , '13' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Enhancing a technical Talk with the Internet'  , '14' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Presenting a Technical Paper'  , '14' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Non-Technical Audience'  , '14' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Proposal'  , '14' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Technical Briefing'  , '14' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'A Dramatic Talk'  , '15' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Make Them Laugh'  , '15' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Resources for Entertainment'  , '15' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Speaking After Dinner'  , '15' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Entertaining Speech'  , '15' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Speaking to Entertain'  , '16' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Keynote Address'  , '16' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Motivational Speech'  , '16' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Professional Seminar'  , '16' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Sales Training Speech'  , '16' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Beginning Your Speech'  , '17' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Concluding Your Speech'  , '18' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Controlling Your Fear'  , '19' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Creating An Introduction'  , '20' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Impromptu Speaking'  , '21' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Know Your Audience'  , '22' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Organizing Your Speech'  , '23' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Preparation And Practice'  , '24' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Selecting Your Topic'  , '25' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Using Body Language'  , '26' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Building Your Thinking Power, Part I: Mental Flexibility'  , '38' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Building Your Thinking Power, Part Ii: The Power Of Ideas'  , '39' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'From Speaker To Trainer'  , '40' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'How To Listen Effectively'  , '41' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Speechcraft Starter Kit'  , '42' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Art Of Effective Evaluation'  , '43' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'How To Conduct Productive Meetings'  , '44' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Improving Your Management Skills'  , '45' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Leadership, Part I: Characteristics Of Effective Leaders'  , '46' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Leadership, Part Ii: Developing Your Leadership Skills'  , '47' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Leadership, Part Iii: Working In The Team Environment'  , '48' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Parliamentary Procedure In Action'  , '49' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Closing The Sale'  , '27' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Creating The Best Club Climate'  , '28' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Evaluate To Motivate'  , '29' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Finding New Members For Your Club'  , '30' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Going Beyond Our Club'  , '31' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'How To Be A Distinguished Club'  , '32' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Keeping The Commitment'  , '33' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Meeting Roles And Responsibilities'  , '34' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Mentoring'  , '35' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Moments Of Truth'  , '36' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Toastmasters Educational Program'  , '37' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Critical Thinking: General Evaluator'  , '50' , '4' , '2.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Critical Thinking: Grammarian'  , '50' , '6' , '2.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Critical Thinking: Speech Evaluator'  , '50' , '3' , '2.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Developing Your Facilitation Skills: Befriend a Guest at a Club Meeting'  , '50' , '11' , '7.4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Developing Your Facilitation Skills: General Evaluator'  , '50' , '4' , '7.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Developing Your Facilitation Skills: Table Topics Master'  , '50' , '5' , '7.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Developing Your Facilitation Skills: Toastmaster'  , '50' , '2' , '7.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Giving Feedback: General Evaluator'  , '50' , '4' , '3.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Giving Feedback: Grammarian'  , '50' , '6' , '3.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Giving Feedback: Speech Evaluator'  , '50' , '3' , '3.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Listening and Leadership: Ah-Counter'  , '50' , '7' , '1.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Listening and Leadership: Grammarian'  , '50' , '6' , '1.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Listening and Leadership: Speech Evaluator'  , '50' , '3' , '1.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Listening and Leadership: Table Topics Speaker'  , '50' , '9' , '1.4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Mentoring: HPL Guidance Committee Member'  , '50' , '22' , '9.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Mentoring: Mentor for a New Member'  , '50' , '24' , '9.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Mentoring: Mentor for an Existing Member'  , '50' , '25' , '9.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Motivating People: General Evaluator'  , '50' , '4' , '8.5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Motivating People: Membership Campaign Chair'  , '50' , '23' , '8.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Motivating People: PR Campaign Chair'  , '50' , '26' , '8.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Motivating People: Speech Evaluator'  , '50' , '3' , '8.4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Motivating People: Toastmaster'  , '50' , '2' , '8.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Organization and Delegation: Assist the Clubs Webmaster'  , '50' , '10' , '6.6' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Organization and Delegation: Help Organise a Club Membership Campaign or Contest'  , '50' , '17' , '6.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Organization and Delegation: Help Organise a Club Public Relations Campaign'  , '50' , '18' , '6.4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Organization and Delegation: Help Organise a Club Special Event'  , '50' , '19' , '6.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Organization and Delegation: Help Organise a Club Speech Contest'  , '50' , '20' , '6.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Organization and Delegation: Help Produce a Club Newsletter'  , '50' , '21' , '6.5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Planning and Implementation: General Evaluator'  , '50' , '4' , '5.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Planning and Implementation: Speaker'  , '50' , '1' , '5.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Planning and Implementation: Table Topics Master'  , '50' , '5' , '5.4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Planning and Implementation: Toastmaster'  , '50' , '2' , '5.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Team Building: Club Newsletter Editor'  , '50' , '12' , '10.7' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Team Building: Club PR Campaign Chair'  , '50' , '13' , '10.4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Team Building: Club Special Event Chair'  , '50' , '14' , '10.6' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Team Building: Club Speech Contest Chair'  , '50' , '15' , '10.5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Team Building: Club Webmaster'  , '50' , '16' , '10.8' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Team Building: General Evaluator'  , '50' , '4' , '10.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Team Building: Membership Campaign Chair'  , '50' , '23' , '10.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Team Building: Toastmaster'  , '50' , '2' , '10.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Time Management: Grammarian'  , '50' , '6' , '4.5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Time Management: Speaker'  , '50' , '1' , '4.3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Time Management: Table Topics Master'  , '50' , '5' , '4.4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Time Management: Timer'  , '50' , '8' , '4.1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Time Management: Toastmaster'  , '50' , '2' , '4.2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Building A Team'  , '51' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Delegate To Empower'  , '52' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Developing A Mission'  , '53' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Giving Effective Feedback'  , '54' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Goal Setting And Planning'  , '55' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Motivating People'  , '56' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Resolving Conflict'  , '57' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Service And Leadership'  , '58' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Leader as a Coach'  , '59' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'The Visionary Leader'  , '60' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Values and Leadership'  , '61' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Part 1: Learning About Leadership'  , '62' , '1' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Part 2: Choosing Your Objectives'  , '62' , '1' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Part 3: Winning Commitment'  , '62' , '1' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Part 4: Working The Plan'  , '62' , '1' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Part 5: Analysing and Presenting Your Results'  , '62' , '1' , '5' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'No project'  , '63' , '35' , '6' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Coach a member to Competent Communicator 3'  , '63' , '36' , '1' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'At least 6 months as a Club Officer and participated in the Club Success Plan'  , '63' , '37' , '2' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Participated in a Officer Training Program'  , '63' , '38' , '3' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Served a complete term as a District Leader'  , '63' , '39' , '4' , 'bulk' );
INSERT INTO TMI_PROJECTS ( project , manualsID , rolesID , tmiorder , createdby ) VALUES ( 'Served successfully as a club sponsor, mentor or coach'  , '63' , '40' , '5' , 'bulk' );
SELECT * FROM TMI_PROJECTS ;

DROP TABLE IF EXISTS TMI_ROLES ;
CREATE TABLE TMI_ROLES ( id Serial , role VARCHAR(255) , role_type VARCHAR(255) , contestable VARCHAR(255) , tmiorder INT , created TIMESTAMP DEFAULT CURRENT_TIMESTAMP , createdby VARCHAR(255) , updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP , updatedby VARCHAR(255) );
INSERT INTO TMI_ROLES ( role , role_type , contestable , tmiorder , createdby ) VALUES ( 'Speaker'  , 'Project' , 'Yes' , '1' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , contestable , tmiorder , createdby ) VALUES ( 'Toastmaster'  , 'Project' , 'Yes' , '2' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , contestable , tmiorder , createdby ) VALUES ( 'Speech Evaluator'  , 'Project' , 'Yes' , '3' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , contestable , tmiorder , createdby ) VALUES ( 'General Evaluator'  , 'Project' , 'Yes' , '4' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , contestable , tmiorder , createdby ) VALUES ( 'Table Topics Master'  , 'Project' , 'Yes' , '5' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , contestable , tmiorder , createdby ) VALUES ( 'Grammarian'  , 'Project' , 'Yes' , '6' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , contestable , tmiorder , createdby ) VALUES ( 'Ah-Counter'  , 'Project' , 'Yes' , '7' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , contestable , tmiorder , createdby ) VALUES ( 'Timer'  , 'Project' , 'Yes' , '8' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , contestable , tmiorder , createdby ) VALUES ( 'Table Topics Speaker'  , 'Project' , 'Yes' , '9' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Assist the Clubs Webmaster'  , 'Project' , '10' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Befriend a Guest at a Club Meeting'  , 'Project' , '11' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Club Newsletter Editor'  , 'Project' , '12' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Club PR Campaign Chair'  , 'Project' , '13' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Club Special Event Chair'  , 'Project' , '14' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Club Speech Contest Chair'  , 'Project' , '15' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Club Webmaster'  , 'Project' , '16' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Help Organise a Club Membership Campaign or Contest'  , 'Project' , '17' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Help Organise a Club Public Relations Campaign'  , 'Project' , '18' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Help Organise a Club Special Event'  , 'Project' , '19' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Help Organise a Club Speech Contest'  , 'Project' , '20' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Help Produce a Club Newsletter'  , 'Project' , '21' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'HPL Guidance Committee Member'  , 'Project' , '22' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Membership Campaign Chair'  , 'Project' , '23' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Mentor for a New Member'  , 'Project' , '24' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Mentor for an Existing Member'  , 'Project' , '25' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'PR Campaign Chair'  , 'Project' , '26' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Sergeant at Arms'  , 'Executive Team' , '27' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'President'  , 'Executive Team' , '28' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'VP Education'  , 'Executive Team' , '29' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'VP Membership'  , 'Executive Team' , '30' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'VP Public Relations'  , 'Executive Team' , '31' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Secretary'  , 'Executive Team' , '32' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Treasurer'  , 'Executive Team' , '33' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'Guest'  , 'Other' , '34' , 'bulk' );
INSERT INTO TMI_ROLES ( role , role_type , tmiorder , createdby ) VALUES ( 'No role'  , 'Other' , '35' , 'bulk' );
INSERT INTO TMI_ROLES ( role , tmiorder , createdby ) VALUES ( 'Coach a member to Competent Communicator 3'  , '36' , 'bulk' );
INSERT INTO TMI_ROLES ( role , tmiorder , createdby ) VALUES ( 'At least 6 months as a Club Officer and participated in the Club Success Plan'  , '37' , 'bulk' );
INSERT INTO TMI_ROLES ( role , tmiorder , createdby ) VALUES ( 'Participated in a Officer Training Program'  , '38' , 'bulk' );
INSERT INTO TMI_ROLES ( role , tmiorder , createdby ) VALUES ( 'Served a complete term as a District Leader'  , '39' , 'bulk' );
INSERT INTO TMI_ROLES ( role , tmiorder , createdby ) VALUES ( 'Served successfully as a club sponsor, mentor or coach'  , '40' , 'bulk' );
INSERT INTO TMI_ROLES ( role , tmiorder , createdby ) VALUES ( 'All roles'  , '41' , 'bulk' );
INSERT INTO TMI_ROLES ( createdby ) VALUES ( 'bulk' );
SELECT * FROM TMI_ROLES ;


/*==========================================================================================
ADD FORGIEGN KEY"S TO TABLES
=========================================================================================*/

ALTER TABLE TMI_PROJECTS
	ADD FOREIGN KEY ( manualsID ) REFERENCES TMI_MANUALS ( id ) ,
   	ADD FOREIGN KEY ( rolesID ) REFERENCES TMI_ROLES ( id );

ALTER TABLE TMI_MANUALS
   	ADD FOREIGN KEY ( manual_groupsID ) REFERENCES TMI_MANUAL_GROUPS ( id );

ALTER TABLE TMI_MANUAL_GROUPS
   	ADD FOREIGN KEY ( qualificationsID ) REFERENCES TMI_QUALIFICATIONS ( id );

ALTER TABLE TMI_QUALIFICATIONS
   	ADD FOREIGN KEY ( tracksID ) REFERENCES TMI_TRACKS ( id );

ALTER TABLE TMI_QUALS_MANUALGROUPS
   	ADD FOREIGN KEY ( qualificationID ) REFERENCES TMI_QUALIFICATIONS ( id ),
   	ADD FOREIGN KEY ( manual_groupID ) REFERENCES TMI_MANUAL_GROUPS ( id );

/*==========================================================================================
SELECT STATEMENT CONNECTING ALL TABLES
=========================================================================================*/

/*
SELECT * FROM TMI_TRACKS ;
SELECT * FROM TMI_QUALIFICATIONS ;
SELECT * FROM TMI_QUALS_MANUALGROUPS ;
SELECT * FROM TMI_MANUAL_GROUPS ;
SELECT * FROM TMI_MANUALS ;
SELECT * FROM TMI_PROJECTS ;
SELECT * FROM TMI_ROLES ;
*/
