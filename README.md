GCPD Tracker System 
===
This is the completed code for Phase 5 of the Gotham City Police Department Tracker System.  This project was assigned in the fall of 2018 as a 67-272 project at Carnegie Mellon University, Information Systems department.  More information about the project can be found at [67272.cmuis.net](https://67272.cmuis.net).

It is a fully functional crime tracking system with all CRUD operations working. Authentication and Authorization for all necessary personnel have been handled.

Populating the dev database
---
You can populate the development database with a decent number of fictitious records with the command `rake db:populate`.  There are over 50 investigations generated, but only one is initially closed.

There is also a large set of criminals generated this time around, including many from Batman's famous 'Rogues Gallery'. Great reading and worth formatting appropriately.


Notes on tests
---
There is 100% test coverage for existing models and helpers.  However, if there are significant changes to some of the existing models, then tests should be updated so that coverage remains at 100%.

Controllers and Views have been written but have not been tested to allow for user flexibility.


Cloning this repo
---
After cloning this repo to your laptop, switch into the project directory and remove the reference to `origin` with the following:

```
  git remote rm origin
```

This will stop you from accidentally trying to push changes to to the default remote repository


HAPPY CRIMINAL HUNTING AND MAY THE FORCE BE WITH YOU!

