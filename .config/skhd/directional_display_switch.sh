
#!/bin/bash

# Get the current display ID
current_display_id=$(yabai -m query --displays | jq -r '.[] | select(.frame.x == 0 and .frame.y == 0) | .id')

if [ "$current_display_id" == "1" ]; then
    # If on display 1, switch to display 2
    yabai -m display --focus 2
else
    # If on display 2, switch to display 1
    yabai -m display --focus 1
fi
