/*
How this level designer works:
1. Generate an array of all of the rooms and halls that will exist in this dungeon.
    a. Determine the number of rooms and halls desired in this dungeon
    b. Create a 2D array 'things' for all of the rooms/halls.  Rows are room/hall #, while columns are the properties of that room such as position and dimentions.
    c. Create the first room, starting at (0, 0), with random dimensions.
    d. Create all of the other halls and rooms as connections to previous objects.
    e. Create the last room.
2. Generate an array of objects in the dungeon (loot, monsters, traps, etc)
    a. Make an 'objects' array for all of the objects that will be in the dungeon
    b. For each loot/monster, choose a room/hall to place it in (from the initial 'things' array), and a random location within that room.
    c. Check if there is already an object at that position in the 'objects' array
        i. if not, add that loot to the objects array
        ii. if so, go back to a.
3. Make the actual room from room_final
    a. Find the farthest rooms in all directions, and get the total height and width of the dungeon.
    b. Create a room, set its dimensions, and set the background tile.
    c. Loop through the room_final array, creating objects at the specified positions

Congratulations, now you have a dungeon!

Possible improvements:
 - Make halls and rooms store which sides are being used, so that new rooms/halls don't build off of those sides into existing rooms (or have a much less chance to)
*/


//1. Generate an array of all of the rooms and halls that will exist in this dungeon


//a. determine the number of rooms and halls desired in this dungeon

rooms = argument0; //the number of rooms to generate
room_var = argument1; //the amount to randomly vary the above number by
//ie total number of rooms is somewhere random between rooms - room_var and rooms + room_var
halls = argument1; //same as above
hall_var = argument3;
rooms += floor(random_range(-room_var, room_var + 1)); //rooms will vary positively or negatively by room_var
halls += floor(random_range(-hall_var, hall_var + 1));//same


//b. Create a 2D array 'things' for all of the rooms/halls.


things[rooms + halls - 1, 4] = 0;


//c. Create the first room, starting at (0, 0), with random dimensions.

rooms--;
things[rooms + halls, 4] = 0;    //0 = room, 1 = horizontal hall, 1 = vertical hall
things[rooms + halls, 0] = 0;   //x pos
things[rooms + halls, 1] = 0;   //y pos
things[rooms + halls, 2] = floor(random_range(5, 11));  //width
things[rooms + halls, 3] = floor(random_range(5, 11));  //height



//d. Create all of the other halls and rooms as connections to previous objects.

while(rooms + halls > 0)
{
    //determine whether to do a room or a hall
    if(floor(random_range(0, rooms + halls - 1)) < halls || (rooms == 1 && halls == 0))  //randomly choose between rooms and halls, but prefer the one with more remaining to be built.  also leave one room to be built at the very end
    {
        build_room = false;
        halls--;
    }
    else
    {
        build_room = true;
        rooms--;
    }
     
    //if room, make width and height
    if(build_room)
    {
        things[rooms + halls, 4] = 0;   //0 is for room
        things[rooms + halls, 2] = floor(random_range(5, 11));
        things[rooms + halls, 3] = floor(random_range(5, 11));
    }
    else   //building a hall
    {
        things[rooms + halls, 4] = floor(random_range(1, 3));   //choose horizontal or vertical
        if(things[rooms + halls, 4] == 1)   //if horizontal
        {   //make the hall wider than it is tall
            things[rooms + halls, 2] = floor(random_range(6, 16));
            things[rooms + halls, 3] = floor(random_range(2, 4));
        }
        else    //the hall is vertical
        {   //make the hall taller than it is wide
            things[rooms + halls, 2] = floor(random_range(2, 4));
            things[rooms + halls, 3] = floor(random_range(6, 16));
        }
    }
    
    //pick an existing thing to build off of
    start_room = floor(random_range(rooms + halls + 1, array_length_1d(things)));
    //pick a side of that thing to build off of
    side = floor(random_range(0, 4)); //0 = bottom, 1 = right, 2 = top, 3 = left
    //generate start_point_x and start_point_y
    switch side
    {
        case 0: //the room/hall to be added connects to the bottom of an existing room
            things[rooms + halls, 0] = things[start_room, 0] + floor(random_range(0, things[start_room, 2]));
            things[rooms + halls, 1] = things[start_room, 1] + things[start_room, 3];
            break;
        case 1: //the room/hall to be added connects to the right of an existing room
            things[rooms + halls, 0] = things[start_room, 0] + things[start_room, 2];
            things[rooms + halls, 1] = things[start_room, 1] + floor(random_range(0, things[start_room, 3]));
            break;
        case 2: //the room/hall to be added connects to the top of an existing room
            things[rooms + halls, 0] = things[start_room, 0] + floor(random_range(0, things[start_room, 2]));
            things[rooms + halls, 1] = things[start_room, 1] - things[rooms + halls, 3];
            break;
        case 3: //the room/hall to be added connects to the left of an existing room
            things[rooms + halls, 0] = things[start_room, 0] - things[rooms + halls, 3];
            things[rooms + halls, 1] = things[start_room, 1] + floor(random_range(0, things[start_room, 3]));
    }
}

//2. Generate an array of objects in the dungeon (loot, monsters, traps, etc)
//a. Make an 'objects' array for all of the objects that will be in the dungeon
//b. For each loot/monster, choose a room/hall to place it in (from the initial 'things' array), and a random location within that room.
//c. Check if there is already an object at that position in the 'objects' array
//i. if not, add that loot to the objects array
//ii. if so, go back to a.
//3. Make the actual room from room_final
//a. Find the farthest rooms in all directions, and get the total height and width of the dungeon.
//b. Create a room, set its dimensions, and set the background tile.
//c. Loop through the room_final array, creating objects at the specified positions


