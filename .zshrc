# Created by newuser for 5.9
eval "$(starship init zsh)"
alias cpuTemperature="watch -n 1 \"sensors | grep -A 5 'k10temp\|zenpower'; echo ''; ps -eo pid,cmd,%cpu --sort=-%cpu | head -n 15\""
