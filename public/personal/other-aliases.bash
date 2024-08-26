alias plex-proxy='sudo ssh -A -L 443:10.253.102.200:443 -L 902:10.253.102.200:902 -L 903:10.253.102.200:903 -L 5480:10.253.102.200:5480 -L 8443:10.253.1.50:443 -L 9443:10.253.1.101:443 root@162.236.21.179'
alias deemix='docker run -d --name Deemix -v /Users/play/deemix/music/:/downloads -v /Users/play/deemix/config/:/config -e PUID=1000 -e PGID=1000 -e UMASK_SET=022 -e DEEMIX_SINGLE_USER=true -p 6595:6595 registry.gitlab.com/bockiii/deemix-docker'