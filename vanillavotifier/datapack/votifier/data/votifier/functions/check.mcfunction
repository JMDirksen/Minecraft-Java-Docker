# Set check interval
schedule function votifier:check 1s

# Check if someone has voted
execute if entity @a[scores={voted=1..}] run function votifier:voted
