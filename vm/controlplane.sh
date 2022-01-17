#!/bin/bash
set -euxo pipefail

# configure the motd.
# NB this was generated at http://patorjk.com/software/taag/#p=display&f=Big&t=rke2%0Aserver.
#    it could also be generated with figlet.org.
cat >/etc/motd <<'EOF'

  _       _                _        ___                    
 | |     | |              | |      |__ \                   
 | | __ _| |__ ______ _ __| | _____   ) |                  
 | |/ _` | '_ \______| '__| |/ / _ \ / /                   
 | | (_| | |_) |     | |  |   <  __// /_                   
 |_|\__,_|_.__/   _  |_|  |_|\_\___|____|                  
                 | |           | |     | |                 
   ___ ___  _ __ | |_ _ __ ___ | |_ __ | | __ _ _ __   ___ 
  / __/ _ \| '_ \| __| '__/ _ \| | '_ \| |/ _` | '_ \ / _ \
 | (_| (_) | | | | |_| | | (_) | | |_) | | (_| | | | |  __/
  \___\___/|_| |_|\__|_|  \___/|_| .__/|_|\__,_|_| |_|\___|
                                 | |                       
                                 |_|                       

EOF
