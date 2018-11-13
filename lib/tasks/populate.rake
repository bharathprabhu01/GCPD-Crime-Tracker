require 'faker' 
require 'factory_bot_rails'

namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Step 0: initial set-up
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate to set up db structure based on latest migrations
    Rake::Task['db:migrate'].invoke
    
    # Get the faker gem (see docs at http://faker.rubyforge.org/rdoc/)
    # require 'faker' 
    # require 'factory_bot_rails'

    ### Step 1: Create crimes
    murder1  = FactoryBot.create(:crime, name: "Murder, First Degree")
    murder2  = FactoryBot.create(:crime, name: "Murder, Second Degree")
    manslt   = FactoryBot.create(:crime, name: "Manslaughter")
    manslt2  = FactoryBot.create(:crime, name: "Manslaughter, Second Degree", active: false)
    arson    = FactoryBot.create(:crime, name: "Arson")
    robbery  = FactoryBot.create(:crime, name: "Armed Robbery")
    assault  = FactoryBot.create(:crime, name: "Assault")
    battery  = FactoryBot.create(:crime, name: "Battery")
    kidnap   = FactoryBot.create(:crime, name: "Kidnapping")
    traf     = FactoryBot.create(:crime, name: "Drug Trafficking")
    possess  = FactoryBot.create(:crime, name: "Drug Possession")
    trespass = FactoryBot.create(:crime, name: "Trespass", felony: false)
    ptheft   = FactoryBot.create(:crime, name: "Petty Theft", felony: false)
    d_peace  = FactoryBot.create(:crime, name: "Disturbing the Peace", felony: false)
    vandal   = FactoryBot.create(:crime, name: "Vandalism", felony: false)

    felonies     = Crime.felonies.active.alphabetical.to_a
    misdemeanors = Crime.misdemeanors.active.alphabetical.to_a

    ### STEP 2: Create units
    major_crimes   = FactoryBot.create(:unit)
    headquarters   = FactoryBot.create(:unit, name: "Headquarters")
    homicide       = FactoryBot.create(:unit, name: "Homicide")
    forensics      = FactoryBot.create(:unit, name: "Forensics")
    coroner        = FactoryBot.create(:unit, name: "Coroner")
    narcotics      = FactoryBot.create(:unit, name: "Narcotics")
    patrol         = FactoryBot.create(:unit, name: "Patrol")
    swat           = FactoryBot.create(:unit, name: "S.W.A.T.", active: false)  # became quick response team...
    quick_response = FactoryBot.create(:unit, name: "Quick Response Team")
    puts "Created units"

    ### STEP 3: Create officers and users
    # At HQ
    jgordon_user = FactoryBot.create(:user, username: "jgordon", role: "commish")
    jgordon  = FactoryBot.create(:officer, first_name: "Jim", last_name: "Gordon", rank: "Commissioner", user: jgordon_user, unit: headquarters, ssn: "064-23-0511")
    gloeb_user = FactoryBot.create(:user, username: "gloeb", role: "commish")
    gloeb    = FactoryBot.create(:officer, first_name: "Gillian", last_name: "Loeb", rank: "Commissioner", user: jgordon_user, unit: headquarters, active: false)
    sxue_user = FactoryBot.create(:user, username: "sxue", role: "officer")
    sxue     = FactoryBot.create(:officer, first_name: "Stacey", last_name: "Xue", rank: "Officer", user: sxue_user, unit: headquarters)
    nfields_user = FactoryBot.create(:user, username: "nfields", role: "chief")
    nfields     = FactoryBot.create(:officer, first_name: "Nora", last_name: "Fields", rank: "Captain", user: nfields_user, unit: coroner)
    makins_user = FactoryBot.create(:user, username: "makins", role: "chief")
    makins     = FactoryBot.create(:officer, first_name: "Michael", last_name: "Akins", rank: "Captain", user: makins_user, unit: forensics)
    mbarra_user = FactoryBot.create(:user, username: "mbarra", role: "officer")
    mbarra     = FactoryBot.create(:officer, first_name: "Mac", last_name: "Barra", rank: "Officer", user: mbarra_user, unit: forensics)
    fdiaz_user = FactoryBot.create(:user, username: "fdiaz", role: "officer")
    fdiaz     = FactoryBot.create(:officer, first_name: "Flora", last_name: "Diaz", rank: "Officer", user: fdiaz_user, unit: forensics)
    puts "Created HQ & related officers"

    # Major Crimes
    msawyer_user = FactoryBot.create(:user, username: "msawyer", role: "chief")
    msawyer  = FactoryBot.create(:officer, first_name: "Maggie", last_name: "Sawyer", rank: "Captain", user: msawyer_user, unit: major_crimes)
    sessen_user = FactoryBot.create(:user, username: "sessen", role: "chief")
    sessen  = FactoryBot.create(:officer, first_name: "Sarah", last_name: "Essen", rank: "Captain", user: sessen_user, unit: major_crimes, active: false)
    dcornwell_user = FactoryBot.create(:user, username: "dcornwell", role: "officer")
    dcornwell  = FactoryBot.create(:officer, first_name: "David", last_name: "Cornwell", rank: "Lieutenant", user: dcornwell_user, unit: major_crimes)
    jblake_user  = FactoryBot.create(:user, username: "jblake", role: "officer")
    jblake   = FactoryBot.create(:officer, user: jblake_user, unit: major_crimes)
    jazeveda_user = FactoryBot.create(:user, username: "jazeveda", role: "officer")    
    jazeveda = FactoryBot.create(:officer, first_name: "Josh", last_name: "Azeveda", rank: "Detective", user: jazeveda_user, unit: major_crimes)
    jbartlett_user = FactoryBot.create(:user, username: "jbartlett", role: "officer")    
    jbartlett = FactoryBot.create(:officer, first_name: "Jane", last_name: "Bartlett", rank: "Detective", user: jbartlett_user, unit: major_crimes)
    hbullock_user = FactoryBot.create(:user, username: "hbullock", role: "officer")    
    hbullock = FactoryBot.create(:officer, first_name: "Harvey", last_name: "Bullock", rank: "Detective", user: hbullock_user, unit: major_crimes)
    tburke_user = FactoryBot.create(:user, username: "tburke", role: "officer")    
    tburke = FactoryBot.create(:officer, first_name: "Thomas", last_name: "Burke", rank: "Detective", user: tburke_user, unit: major_crimes)
    rchandler_user = FactoryBot.create(:user, username: "rchandler", role: "officer")    
    rchandler = FactoryBot.create(:officer, first_name: "Romy", last_name: "Chandler", rank: "Detective", user: rchandler_user, unit: major_crimes)
    ecohen_user = FactoryBot.create(:user, username: "ecohen", role: "officer")    
    ecohen = FactoryBot.create(:officer, first_name: "Eric", last_name: "Cohen", rank: "Detective", user: ecohen_user, unit: major_crimes)
    jdavies_user = FactoryBot.create(:user, username: "jdavies", role: "officer")    
    jdavies = FactoryBot.create(:officer, first_name: "Jackson", last_name: "Davies", rank: "Detective Sergeant", user: jdavies_user, unit: major_crimes)
    ncrowe_user = FactoryBot.create(:user, username: "ncrowe", role: "officer")    
    ncrowe = FactoryBot.create(:officer, first_name: "Nelson", last_name: "Crowe", rank: "Detective", user: ncrowe_user, unit: major_crimes)
    varrazzio_user = FactoryBot.create(:user, username: "varrazzio", role: "officer")    
    varrazzio = FactoryBot.create(:officer, first_name: "Vincent", last_name: "Arrazzio", rank: "Detective Sergeant", user: varrazzio_user, unit: major_crimes)
    mc_officers = [dcornwell,jblake,jazeveda,jbartlett,hbullock,tburke,rchandler,ecohen,jdavies,ncrowe,varrazzio]
    puts "Created Major Crimes officers"

    # Homicide
    calvarez_user = FactoryBot.create(:user, username: "calvarez", role: "officer")
    calvarez  = FactoryBot.create(:officer, first_name: "Carlos", last_name: "Alvarez", rank: "Detective", user: calvarez_user, unit: homicide)
    jbard_user = FactoryBot.create(:user, username: "jbard", role: "officer")
    jbard  = FactoryBot.create(:officer, first_name: "Jason", last_name: "Bard", rank: "Detective", user: jbard_user, unit: homicide)
    bbilbao_user = FactoryBot.create(:user, username: "bbilbao", role: "officer")
    bbilbao  = FactoryBot.create(:officer, first_name: "Brian", last_name: "Bilbao", rank: "Lieutenant", user: bbilbao_user, unit: homicide)
    ghennelly_user = FactoryBot.create(:user, username: "ghennelly", role: "chief")
    ghennelly  = FactoryBot.create(:officer, first_name: "Gerrard", last_name: "Hennelly", rank: "Captain", user: ghennelly_user, unit: homicide)
    dpeak_user = FactoryBot.create(:user, username: "dpeak", role: "officer")
    dpeak  = FactoryBot.create(:officer, first_name: "Donald", last_name: "Peak", rank: "Officer", user: dpeak_user, unit: homicide)
    rmulcahey_user = FactoryBot.create(:user, username: "rmulcahey", role: "officer")
    rmulcahey  = FactoryBot.create(:officer, first_name: "Rebecca", last_name: "Mulcahey", rank: "Officer", user: rmulcahey_user, unit: homicide)
    homicide_officers = [calvarez,jbard,bbilbao,dpeak,rmulcahey]
    puts "Created Homicide officers"

    # Patrol
    cmason_user = FactoryBot.create(:user, username: "cmason", role: "chief")
    cmason  = FactoryBot.create(:officer, first_name: "Catherine", last_name: "Mason", rank: "Captain", user: cmason_user, unit: patrol)
    50.times do
      create_officer_and_user(patrol)
    end
    puts "Created Patrol officers"

    # Narcotics
    ddelaware_user = FactoryBot.create(:user, username: "ddelaware", role: "chief")
    ddelaware  = FactoryBot.create(:officer, first_name: "Derek", last_name: "Mason", rank: "Captain", user: ddelaware_user, unit: narcotics)
    12.times do
      create_officer_and_user(narcotics)
    end
    puts "Created Narcotics officers"

    # Quick Response Team
    jcolby_user = FactoryBot.create(:user, username: "jcolby", role: "chief")
    jcolby  = FactoryBot.create(:officer, first_name: "James", last_name: "Colby", rank: "Captain", user: jcolby_user, unit: quick_response)
    24.times do
      create_officer_and_user(quick_response)
    end
    puts "Created Quick Response Team officers"

    ### STEP 4: Create the Rogues Gallery
    joker       = FactoryBot.create(:criminal, notes: "The Joker is a homicidal maniac with a clown-like appearance, bent on creating havoc in Gotham City and fighting a never-ending battle against Batman. His arsenal of weapons includes razor-cards, acid-spewing flowers, and fatal laughing-gas. He is responsible for countless deaths but has also been certified as insane for legal proceedings.")
    catwoman    = FactoryBot.create(:criminal, first_name: "Selina", last_name: "Kyle", aka: "Catwoman", convicted_felon: true, notes: "Selina Kyle is an accomplished jewel thief. Highly acrobatic and able to move quickly and silently.  Catwoman is adept at using many weapons, but her favorite weapon is a whip.  In normal life, Selina Kyle has been in an on-again-off-again relationship with billionaire Bruce Wayne.")
    bane        = FactoryBot.create(:criminal, first_name: "Edmund", last_name: "Dorrance", aka: "Bane", convicted_felon: true, enhanced_powers: true, notes: "The international masked criminal known as Bane has immense strength that comes from a super-steroid called Venom. Bane's raw power coupled with his genius level intellect makes him a considerable threat to Batman, having once succeeded in breaking Batman's back.")
    hush        = FactoryBot.create(:criminal, first_name: "Thomas", last_name: "Elliot", aka: "Hush", convicted_felon: true, notes: "Being a victim of abuse rendered Thomas Elliot sociopathic. Before even his teenage years, he was already operating on a high level of sociopathy, going so far as severing the brake line of his parents' car to gain independence from them and inherit the Elliot family fortune. Dr. Thomas Wayne operated on and saved his mother, foiling the young Elliot's plan of parricide. One of the finest surgeons in Gotham City, Thomas Elliot has an incredible, genius-level intellect and is also a master planner, with tactical skills rivaling those of the Caped Crusader. Hush's greatest asset is his talent for thinking like his opponents and for using their abilities against them. Hush is also an expert marksman.")
    killer_croc = FactoryBot.create(:criminal, first_name: "Waylon", last_name: "Jones", aka: "Killer Croc", convicted_felon: true, enhanced_powers: true, notes: "Waylon Jones has a medical condition that warped his body into a massive crocodile-like form. As Croc descended into madness, he sharpened his teeth to razor points and began murdering innocent victims. He possesses super-strength and is immune to toxins.")
    harley      = FactoryBot.create(:criminal, first_name: "Harleen", last_name: "Quinzel", aka: "Harley Quinn", convicted_felon: true, notes: "Dr. Harleen Quinzel was the Joker's psychiatrist at Arkham Asylum until she fell in love with him and subsequently reinvented herself as his madcap sidekick, Harley Quinn. She is often mistreated by the Joker, but that rarely changes how she feels about him.")
    deathstroke = FactoryBot.create(:criminal, first_name: "Slade", last_name: "Wilson", aka: "Deathstroke", convicted_felon: true, enhanced_powers: true, notes: "Chosen for a secret experiment, the Army imbued him with enhanced physical powers in an attempt to create metahuman super soldiers for the U.S. military. Deathstroke became a mercenary soon after the experiment when he defied orders. Slade Wilson's physical and mental attributes have been enhanced as a result of the experimental serum he was given; he possesses heightened strength, agility, durability, and reflexes, and has the ability to utilize up to 90 percent of his brain capacity. Deathstroke also possesses a regenerative healing factor that enables him to recover from physical injury much more rapidly than a normal human; it does, however, have its limits, as it could not heal his missing eye nor can it regenerate entire limbs. This enhanced endurance enables him to survive otherwise fatal injuries, though recovering from such injuries renders him temporarily insane and ferociously animalistic. In addition to being a tactical genius with years of military experience, Deathstroke is an expert in many forms of unarmed combat and martial arts as well, serving as a master of Bōjutsu, Boxing, Jojutsu, Judo, Jujitsu, Karate, and Ninjutsu.")
    clayface    = FactoryBot.create(:criminal, first_name: "Matt", last_name: "Hagan", aka: "Clayface", convicted_felon: true, enhanced_powers: true, notes: "Treasure-hunter Matt Hagen was transformed into the monstrous Clayface by a pool of radioactive protoplasm. He now possesses super-strength and can change his claylike body into any form.")
    riddler     = FactoryBot.create(:criminal, first_name: "Edward", last_name: "Nigma", aka: "Riddler", convicted_felon: true, notes: "Edward Nigma is a criminal mastermind who has a compulsion to challenge Batman by leaving clues to his crimes in the form of riddles, puzzles, and word-games. Nigma's intelligence rivals that of Batman. Nigma often carries a question-mark cane around with him, as well as many other trick puzzle gimmicks.")
    penguin     = FactoryBot.create(:criminal, first_name: "Oswald", last_name: "Cobblepot", aka: "Penguin", convicted_felon: true, notes: "Oswald Chesterfield Cobblepot is a devious bird-themed crime boss who is seldom seen without one of his trick umbrellas. The Penguin uses his nightclub, the Iceberg Lounge, as a front for his criminal activities.")
    poison_ivy  = FactoryBot.create(:criminal, first_name: "Pamela", last_name: "Isley", aka: "Poison Ivy", convicted_felon: true, enhanced_powers: true, notes: "Pamela Lillian Isley, a former student of advanced botanical biochemistry, employs plants of all varieties and their derivatives in her crimes. She has the ability to control all plant life and can create new henchmen with her mutated seeds. She is immune to all plant-based poisons.")
    mr_freeze   = FactoryBot.create(:criminal, first_name: "Victor", last_name: "Fries", aka: "Mr. Freeze", convicted_felon: true, notes: "Dr. Victor Fries is a scientist who accidentally spilled cryogenic chemicals on himself while inventing a freeze-gun. Now requiring subzero temperatures to survive, he uses freeze-inducing weaponry and must wear a fully contained, refrigerated ice-suit. Fries was later reinvented as a tragic figure and occasional antihero: Victor Fries was a brilliant cryogenicist whose beloved wife Nora fell terminally ill. He obsessively searched for a way to cure her, until an industrial accident caused by a greedy business executive turned Fries into a mutant who can only survive in subzero temperatures.")
    ras_al_ghul = FactoryBot.create(:criminal, first_name: "Ra's", last_name: "al Ghul", aka: nil, convicted_felon: false, enhanced_powers: true, notes: "Ra's al Ghul is a centuries-old international eco-terrorist who believes that his actions help bring balance to the world. Ra's al Ghul is the founder of the League of Assassins. Ra's' greatest tools are his Lazarus Pits, which heal any injury including recent death and restore the user back to the prime of life, but cause temporary insanity. His constant exposure to the pits have granted him slightly enhanced endurance, strength, and healing but also comes with the price of a gradual onset of insanity if overused. Due to his expanded life span, Ra's has accumulated a vast knowledge of hand-to-hand combat, chemistry, detective artistry, physics, and martial arts. He has also gained many international contacts and a vast fortune over the course of centuries.")
    scarecrow   = FactoryBot.create(:criminal, first_name: "Jonathan", last_name: "Crane", aka: "Scarecrow", convicted_felon: true, enhanced_powers: true, notes: "Professor Jonathan Crane was an outcast in childhood due to the constant bullying, until he grew up to face his fears as a psychologist and biochemist in the specialization of fear. Kicked out of a university for his unorthodox teaching methods, he now dresses symbolically as a scarecrow, and employs a toxin that causes its victims to hallucinate the presence of what they most fear.")
    two_face    = FactoryBot.create(:criminal, first_name: "Harvey", last_name: "Dent", aka: "Two Face", convicted_felon: true, notes: "Harvey Dent was a district attorney until half of his face was disfigured after being assaulted by mob boss Sal Maroni. Having developed Dissociative identity disorder, Harvey Dent is obsessed with duality and must make most of his decisions with the flip of a coin. As Two-Face, Harvey Dent commits crimes themed around the number two.")
    man_bat     = FactoryBot.create(:criminal, first_name: "Kirk", last_name: "Langstrom", aka: "Man-Bat", convicted_felon: false, enhanced_powers: true, notes: "Dr. Kirk Langstrom invented a serum to give him echolocation to cure his growing deafness. The serum had an unforeseen side-effect, transforming him into the monstrous Man-Bat.")
    puts "Created Rogues Gallery"
    # Other mobsters
    maroni   = FactoryBot.create(:criminal, first_name: "Salvatore", last_name: "Maroni", aka: nil, convicted_felon: true, notes: "Sal Maroni is the leader of the Maroni Crime Family and the gangster most notable for scarring Harvey Dent.")
    rfalcone   = FactoryBot.create(:criminal, first_name: "Carmine", last_name: "Falcone", aka: "The Roman", notes: "Carmine Falcone is a powerful crime boss and the leader of the Falcone Crime Family. He is the father of Alberto Falcone, Mario Falcone, and Sofia Falcone Gigante.")
    sfalcone   = FactoryBot.create(:criminal, first_name: "Sophia", last_name: "Gigante", aka: nil, notes: "Sofia Falcone Gigante is the daughter of mob boss Carmine Falcone.")


    ### STEP 5 (for now, create the rest of the testing context)
    lacey     = FactoryBot.create(:investigation)
    pussyfoot = FactoryBot.create(:investigation, title: "Pussyfoot Heist", description: "Theft of $1.2 million in rare jewels.", crime_location: "2809 West 20th Street", date_opened: 20.months.ago.to_date, date_closed: 18.months.ago.to_date, solved: true, batman_involved: true)
    harbor    = FactoryBot.create(:investigation, title: "Great Gotham Harbor Arson", description: "The burning of the Gotham Harbor. Over $24 million in property damage done.", crime_location: "Gotham Harbor", date_opened: 2.months.ago.to_date, date_closed: nil)
    lacey_crime_1 = FactoryBot.create(:crime_investigation, investigation: lacey, crime: murder1)
    # because you can't assign people to closed investigations
    pussyfoot.date_closed = nil
    pussyfoot.save
    pussyfoot_crime_1 = FactoryBot.create(:crime_investigation, investigation: pussyfoot, crime: robbery)
    pussyfoot_crime_2 = FactoryBot.create(:crime_investigation, investigation: pussyfoot, crime: trespass)
    # now reset the close date
    pussyfoot.date_closed = 18.months.ago.to_date
    pussyfoot.save      
    harbor_crime_1 = FactoryBot.create(:crime_investigation, investigation: harbor, crime: arson)
    lacey_jblake      = FactoryBot.create(:assignment, investigation: lacey, officer: jblake)
    # because you can't assign people to closed investigations
    pussyfoot.date_closed = nil
    pussyfoot.save
    pussyfoot_jblake  = FactoryBot.create(:assignment, investigation: pussyfoot, officer: jblake, start_date: 20.months.ago.to_date, end_date: 18.months.ago.to_date)
    pussyfoot_msawyer = FactoryBot.create(:assignment, investigation: pussyfoot, officer: msawyer, start_date: 19.months.ago.to_date, end_date: 18.months.ago.to_date)
    # now reset the close date
    pussyfoot.date_closed = 18.months.ago.to_date
    pussyfoot.save
    harbor_jazeveda   = FactoryBot.create(:assignment, investigation: harbor, officer: jazeveda, start_date: 2.months.ago.to_date)
    lacey_note_1 = FactoryBot.create(:investigation_note, investigation: lacey, officer: jblake)
    # because you add notes to closed investigations or by unassigned officers
    pussyfoot.date_closed = nil
    pussyfoot.save
    pussyfoot_jblake.end_date = nil
    pussyfoot_jblake.save
    pussyfoot_msawyer.end_date = nil
    pussyfoot_msawyer.save
    pussyfoot_note_1 = FactoryBot.create(:investigation_note, investigation: pussyfoot, officer: jblake, date: 19.months.ago.to_date, content: "Batman provided some important evidence that implicates Selina Kyle as the culprit.")
    pussyfoot_note_2 = FactoryBot.create(:investigation_note, investigation: pussyfoot, officer: msawyer, date: 18.months.ago.to_date, content: "Batman helped apprehend Selina Kyle as the culprit.")
    # now reset the close date
    pussyfoot.date_closed = 18.months.ago.to_date
    pussyfoot.save   
    pussyfoot_jblake.end_date = 18.months.ago.to_date
    pussyfoot_jblake.save
    pussyfoot_msawyer.end_date = 18.months.ago.to_date
    pussyfoot_msawyer.save   
    lacey_joker = FactoryBot.create(:suspect, investigation: lacey, criminal: joker)
    pussyfoot_maroni = FactoryBot.create(:suspect, investigation: pussyfoot, criminal: maroni, added_on: 20.months.ago.to_date, dropped_on: 19.months.ago.to_date)
    pussyfoot_catwoman = FactoryBot.create(:suspect, investigation: pussyfoot, criminal: catwoman, added_on: 19.months.ago.to_date, dropped_on: nil)
  
    20.times do
      days_back = (3..100).to_a.sample
      street_address = Faker::Address.street_name
      investigator = homicide_officers.sample
      murder1_investigation = FactoryBot.create(:investigation, title: "Murder at #{street_address}", description: "A brutal premediated murder at #{street_address}.", crime_location: street_address, date_opened: days_back.days.ago.to_date, date_closed: nil, solved: false, batman_involved: false)
      murder1_ci = FactoryBot.create(:crime_investigation, crime: murder1, investigation: murder1_investigation)
      officer_assignment = FactoryBot.create(:assignment, investigation: murder1_investigation, officer: investigator)
    end
    
    10.times do
      days_back = (1..60).to_a.sample
      street_address = Faker::Address.street_name
      investigator = homicide_officers.sample
      murder2_investigation = FactoryBot.create(:investigation, title: "Murder at #{street_address}", description: "A murder of passion committed at #{street_address}.", crime_location: street_address, date_opened: days_back.days.ago.to_date, date_closed: nil, solved: false, batman_involved: false)
      murder2_ci = FactoryBot.create(:crime_investigation, crime: murder2, investigation: murder2_investigation)
      officer_assignment = FactoryBot.create(:assignment, investigation: murder2_investigation, officer: investigator)
    end
    
    25.times do
      days_back = (3..120).to_a.sample
      street_address = Faker::Address.street_name
      investigator = mc_officers.sample
      this_crime = felonies.sample
      this_investigation = FactoryBot.create(:investigation, title: "Crime at #{street_address}", description: "A terrible #{this_crime.name.downcase} committed at #{street_address}.", crime_location: street_address, date_opened: days_back.days.ago.to_date, date_closed: nil, solved: false, batman_involved: true)
      this_ci = FactoryBot.create(:crime_investigation, crime: this_crime, investigation: this_investigation)
      officer_assignment = FactoryBot.create(:assignment, investigation: this_investigation, officer: investigator)
    end

    puts "Created some investigations, etc."
  end
end

def create_officer_and_user(unit)
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = "#{first_name[0].downcase}#{last_name.downcase}#{rand(999)}"
  this_user = FactoryBot.create(:user, username: username, role: "officer")
  this_officer  = FactoryBot.create(:officer, first_name: first_name, last_name: last_name, rank: "Officer", user: this_user, unit: unit)
end
