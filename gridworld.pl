

/* X,Y is a valid grid position if X is between 1 and 5, and Y is between 1 and 4.
 , is used for AND 
 ; is used for OR
*/
grid_position(X, Y) :- 
    X >= 1, X =< 5,
    Y >= 1, Y =< 4.

/* These are the four walls*/
walls(4,4,4,3).
walls(5,4,5,3).

walls(1,1,1,2).
walls(2,1,2,2).    
    
/* This rule enables the agent to move to the right (i.e. increases X by 1). We can move from (X, Y) to (X2, Y) if (X2, Y) is a grid position. */
move(X, Y, X2, Y) :- X2 is X + 1, grid_position(X2, Y),\+ walls(X,Y,X2,Y). 
/* This wil make you move upwards.*/
move(X, Y, X, Y2)  :- Y2 is Y + 1, grid_position(X,Y2), \+ walls(X,Y,X,Y2).
/* This will make you move downwards */
move(X,Y, X, Y2) :- Y2 is Y - 1, grid_position(X,Y2), \+ walls(X,Y,X,Y2).
/* This will make you move left*/
move(X, Y, X2, Y) :- X2 is X - 1, grid_position(X2,Y), \+ walls(X,Y,X2,Y). 
/*\+ used to add the walls restriction*/


/*Prolog searches for every possible plan. 
  There are an infinite amount of plans (e.g. walk(0,0) walk(0,1) walk(0,0) walk(0,1)...and reapeat) and so we need to limit the search. */    
max_length(Plan):- length(Plan,N), N > 15.     
    
/*----- PLAN
 Recursively plan until the first and third parameters unify and the second and forth parameters unify (i.e. until the agent's current location equals the goal location). */
/* End the plan: */
plan(X,Y,X,Y,Plan,Plan). 

/* Add a move action to the plan 
   \+ is used for NOT (i.e. not provable). 
*/
plan(X0,Y0,X,Y,SoFar,Plan) :-    
    move(X0,Y0,X1,Y1),
    \+ max_length(SoFar),
    plan(X1,Y1,X,Y,[walk(X1,Y1)|SoFar],Plan).    
/*----*/  

/*Our plan will be backwards, so reverse it:*/
find_plan(X0,Y0,X,Y,[walk(X,Y)|Plan],RPlan):- plan(X0,Y0,X,Y,[],Plan), reverse(Plan, RPlan).   

/*----- Our main query, that we will be call to generate a plan*/
/* Query the rule below to find a valid plan */ 
find_plan(X0,Y0,X,Y,Plan) :- find_plan(X0,Y0,X,Y,_,Plan).
/*----*/     
    
    






