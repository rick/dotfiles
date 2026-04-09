if [ -d "/opt/workbrew/opt/ruby/bin" ]; then
    export PATH="/opt/workbrew/opt/ruby/bin:$HOME/bin:/sbin:$PATH"
elif [ -d "/opt/homebrew/opt/ruby/bin" ]; then
    export PATH="/opt/homebrew/opt/ruby/bin:$HOME/bin:/sbin:$PATH"
else
    export PATH="$HOME/bin:/sbin:$PATH"
fi
