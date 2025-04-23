# MySQL_DATA

This container runs once to set up the Volume used by the mysql container.
If you want to preload the the volume with your own mysql data, then
place a data.tar.gz archive file of a mysql database (v 8+) into the root
directory of this repo. 

## Notes

- Ensure the data.tar.gz archive is compatible to postgresql 17.
- Keep the filename exactly as specified
- HGNC internal databases can be found in the University of Cambridge private OneDrive
and is only available to HGNC members of staff [DB test data archive](https://universityofcambridgecloud-my.sharepoint.com/:f:/r/personal/kag56_cam_ac_uk/Documents/Docker%20Volume%20Store?csf=1&web=1&e=A7jFug).

## Reminder of how to create an archive of a Postgresql DB.

Since loading the large amounts of data take a long time (esp. SQL into a DB container) or you rely on persistent data, it is wise to backup and store your docker volumes.

To back up a volume do the following (replace <volume-name> with the actual volume name):

```bash
docker run --rm \
-v <volume-name>:/source \
-v $(pwd):/backup \
alpine tar czvf /backup/data.tar.gz -C /source .
```

The above will run a simple debian container and mount your volume to the containers /source directory and mount your current working directory to the /backup directory also in the container. Once these mounts are set, the container runs tar, creating an archive of your volume in the /backup directory on the container and because this directory is shared with your current working directory, write the archive on your host machine. Save this archive in cloud storage or somewhere safe.
