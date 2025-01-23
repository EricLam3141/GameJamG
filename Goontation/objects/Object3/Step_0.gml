key_up = keyboard_check_pressed(ord("W"))
key_up_held = keyboard_check(ord("W"))
key_down_held = keyboard_check(ord("S"))
key_down = keyboard_check_pressed(ord("S"))
key_right = keyboard_check(ord("D"))
key_left = keyboard_check(ord("A"))


//Ignore all cVsp its irrelevant
///////JUMP//////////////JUMP////////////////////////JUMP///////////jump///////JUMP//////////////JUMP/////////////

if key_up = 1 and grounded = 1
	{
		vsp += jump
		cVsp = vsp
	}
if vsp < 0 and (!key_up_held)
	{
		vsp = max(vsp, jump / jump_mod)
		cVsp = vsp
	}
//////Gravity oooo	
if !stopFall
{
vsp += grv
cVsp = vsp
}
////////// TERMINAL VELOCITY

vsp = clamp(vsp, -vsp_max, vsp_max)
cVsp = vsp
////////// Basic Movement

var hmove = key_right - key_left
if hmove != 0
	{
		hsp = move_speed * hmove
	}
else
	{
		hsp = 0
	}
///////////Code to make your fall go faster or not
		if key_down_held and grounded != 1
		{
			stopFall = true
			var vmove = key_down_held - key_up
			vsp += move_speed * vmove
			cVsp = vsp
		}
		else
		{
			if stopFall
			{
				vsp = grv
				cVsp = vsp
				stopFall = false
			}
			vsp += grv
			cVsp = vsp
			vsp = clamp(vsp, -vsp_max, vsp_max)
			cVsp = vsp
		}

////////Horizontal Collision

if(place_meeting(x + hsp, y, oWallN))
	{
		while(!place_meeting(x + sign(hsp), y, oWallN))
		{
			x = x + sign(hsp)
		}
		hsp = 0
	}

//////////////Vert yurr
if (place_meeting(x, y + vsp, collidableFloors))
{
	while(!place_meeting(x, y + sign(vsp), collidableFloors))
	{
		y = y + sign(vsp)
		
	}
	//This one allows you to drop down through platform
	if key_down while(place_meeting(x, y+sign(vsp), oFloorFT))
	{
		y = y + sign(vsp)
	}
	//This one makes the same platform able to be entered from under
	if vsp < 0 while(place_meeting(x, y+sign(vsp), oFloorFT))
	{
		y = y + sign(vsp)
	}
	
	grounded = 1
	vsp = 0
}
else
{
	grounded = 0
}

	x += hsp
	y += vsp