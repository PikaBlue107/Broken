///Move Weapon
weapons[active_weapon].x = x;
weapons[active_weapon].y = y;

///Update Gun Angle
with weapons[active_weapon]
{
    image_angle = point_direction(x, y, mouse_x, mouse_y);
    flipWeapon();
}
