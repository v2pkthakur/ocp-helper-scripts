# Script to Copy Images from registry.access.redhat.com to local satellite server.
# !/bin/bash
#
ORG_ID=1
PRODUCT_NAME=OCP_39

echo "CREATING PRODUCT....."
hammer product create --name "$PRODUCT_NAME" --organization-id $ORG_ID 

echo "EXPECT ERROR if PRODUCT EXISTS..."


echo "CREATING REPOS....."

PRODUCT_LIST_FILE=`mktemp`
hammer repository list --organization-id "$ORG_ID" --product "$PRODUCT_NAME" > $PRODUCT_LIST_FILE

for i in `grep -v '^#' images-list.txt`
  do
  found=`grep "$i" $PRODUCT_LIST_FILE`
      if [[ -z $found ]]; then
        hammer repository create --name "$i" --organization-id $ORG_ID  --content-type docker --url "https://registry.access.redhat.com" --docker-upstream-name "$i" --product "$PRODUCT_NAME";
      else
          echo "Found Satellite mirror for repository $i"
      fi
  done

echo "SYNCING REPOS...."
REPOS=`hammer --csv repository list --organization-id "$ORG_ID" --product "$PRODUCT_NAME"| cut -d, -f1`

for i in $REPOS
  do
  hammer repository synchronize --id 1 --organization-id 1 --async
  done
