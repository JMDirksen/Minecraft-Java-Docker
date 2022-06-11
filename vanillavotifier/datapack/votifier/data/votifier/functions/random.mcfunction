# Makes sure the max variable has a value (default: generate a number between 1 and 5)
execute unless score $max random matches 1.. run scoreboard players set $max random 5

execute store result score $rnd1 random run data get entity @e[sort=random,limit=1] Pos[0]
execute store result score $rnd2 random run data get entity @e[sort=random,limit=1] Pos[1]
execute store result score $rnd3 random run data get entity @e[sort=random,limit=1] Pos[2]

scoreboard players operation $random random = $rnd1 random
scoreboard players operation $random random += $rnd2 random
scoreboard players operation $random random += $rnd3 random
scoreboard players operation $random random %= $max random
scoreboard players add $random random 1
