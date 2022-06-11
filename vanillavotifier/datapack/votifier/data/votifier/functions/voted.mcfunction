# Generate a random number
scoreboard players set $max random 3
function votifier:random

# Give random item 1
execute if score $random random matches 1 run tellraw @a[scores={voted=1..}] ["",{"text":"Thanks for your vote, here's an apple"}]
execute if score $random random matches 1 run give @a[scores={voted=1..}] apple

# Give random item 2
execute if score $random random matches 2 run tellraw @a[scores={voted=1..}] ["",{"text":"Thanks for your vote, here's a steak"}]
execute if score $random random matches 2 run give @a[scores={voted=1..}] cooked_beef

# Give random item 3
execute if score $random random matches 3 run tellraw @a[scores={voted=1..}] ["",{"text":"Thanks for your vote, here's a bread"}]
execute if score $random random matches 3 run give @a[scores={voted=1..}] bread

# Decrease voted with 1
scoreboard players remove @a[scores={voted=1..}] voted 1
