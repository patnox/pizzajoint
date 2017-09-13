PizzaJoint - A pizza place Point Of Sale (POS) system
=====================================================

Developed using QT C++ and running on MySQL database, PizzaJoint is a complete POS system for a pizza shop.
Tested on windows and linux and touch screen friendly.

DIRECTORY STRUCTURE
-------------------

```
database
    Database sql files. Dump the sql into your MySQL database    
src
    The source code including the QT project file (.pro) and the program settings file (.conf)
```
BUILD IT YOURSELF
-------------------

1. Open the project file using QtCreator. Build the project in release mode. Alternatively, on command line:

	a. Run $qmake
	b. Run make release

2. Modify the settings file pizzajoint.conf and place it in the same directory as your executable before running pizzajoint.

3. Enjoy 

