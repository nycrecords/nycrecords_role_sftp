#   ____  _____  ______ _   _ _____  ______ _____ ____  _____  _____   _____
#  / __ \|  __ \|  ____| \ | |  __ \|  ____/ ____/ __ \|  __ \|  __ \ / ____|
# | |  | | |__) | |__  |  \| | |__) | |__ | |   | |  | | |__) | |  | | (___
# | |  | |  ___/|  __| | . ` |  _  /|  __|| |   | |  | |  _  /| |  | |\___ \
# | |__| | |    | |____| |\  | | \ \| |___| |___| |__| | | \ \| |__| |____) |
#  \____/|_|____|______|_|_\_|_|__\_\______\_____\____/|_|  \_\_____/|_____/
#          __________________________     _____
#         / ____|  ____|__   __|  __ \   / ____|
#        | (___ | |__     | |  | |__) | | (___   ___ _ ____   _____ _ __
#         \___ \|  __|    | |  |  ___/   \___ \ / _ \ '__\ \ / / _ \ '__|
#         ____) | |       | |  | |       ____) |  __/ |   \ V /  __/ |
#        |_____/|_|       |_|  |_|      |_____/ \___|_|    \_/ \___|_|
#
#
# This script sets up an SFTP Server for the OpenRecords application.
#
# Assumptions:
#   - OS: Red Hat Enterprise Linux v6.x
#   - Root privileges
#   - This script should be run from the /root directory. Absolute paths are used.
#     Please update paths if directory is different.

# 1. Create SFTP Users group
groupadd sftpusers

# 2. Create SFTP User
useradd -g sftpusers -d /data/uploads -s /sbin/nologin openrecords-sftp

# 3. Modify Upload Directory permissions
chown -R openrecords-sftp:sftpusers /data/uploads
chown root:root /data
chmod 755 /data

# 4. Modify sshd_config
# vi /etc/ssh/sshd_config
# Add the below to the bottom of the file
# Subsystem       sftp    internal-sftp

# # SFTP Configuration
# Match Group sftpusers
#        ChrootDirectory /data
#        AllowTcpForwarding no
#        ForceCommand internal-sftp
#        X11Forwarding no

# 5. Restart sshd service
service sshd restart
