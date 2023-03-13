# bash/zsh

##
#   git-retag.bash
#   ** you're proabably not supposed to do this **
#   move an existing tag from <old commit> to HEAD
#   
#   use it like this: `retag <tagname>`
#

# the tag you want to move
TAG=$1

# check for the tag, it should exist
# if it does not exist, complain then bail
CONTROL="$(git tag -l $TAG)"
if [[ -z $CONTROL ]]
    then
        echo 'could not find tag '"$TAG"'... bailing'
        exit
fi

# tag exists... move it.
echo 'moving tag: '"$TAG"

#1. remove the tag from the remote
echo 'removing tag:'"$TAG"
git tag -d $1
git push origin :refs/tags/$1

#2. tag the current commit (HEAD)
echo 're-create tag '"$TAG"' on HEAD'
git tag -f $1

#3. push the update
echo 'push the updated tag'
git push --tags
