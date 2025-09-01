# Intro

Data is extremely important in MijnBureau because users will create and share data. If you use the Demo environment we deploy all datastores like postgresql databases, redis caches and minio object stores, but it will not contain any backup and restore features. For the production environment we do not deploy datastores and you need to configure MijnBureau to connect to externally managed datastores.

The reason for not deploying the datastores in production is because you often need specialized tools for your backup&restory and disaster recovery. Since every organizations handles its data differently we decided to exclude the datastores. Some organization might use kubernetes datastores but others might use externally managed datastores

When you deploy a production environment you need to prepare the datastores beforehand and configure MijnBureau to connect to them.

MijnBureau also uses PVC that contain important data. Please make sure you also backup these when you run in production. [Velero](https://velero.io/) is an populair tool that can handle the backups of PVCs.
