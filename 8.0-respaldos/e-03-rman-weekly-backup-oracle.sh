#!/bin/bash
set -e
rman target / <<EOF
RUN {
    BACKUP INCREMENTAL LEVEL 0 DATABASE
        TAG 'WEEKLY_BACKUP'
        FORMAT '/unam/proyecto-final/proyecto-final/backups/weekly_%U.bkp';
    BACKUP ARCHIVELOG ALL
        FORMAT '/unam/proyecto-final/proyecto-final/backups/archivelogs_%U.bkp'
        DELETE INPUT;
    DELETE NOPROMPT OBSOLETE;
}
EXIT;
EOF
