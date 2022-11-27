set -e

PROJECT_NAME="$1"
echo $PROJECT_NAME

sed -i.bak "s/nimtemplate/$PROJECT_NAME/g" tests/test.nim src/nimtemplate.nim nimtemplate.nimble

mv src/nimtemplate src/$PROJECT_NAME
mv src/nimtemplate.nim src/$PROJECT_NAME.nim

mv nimtemplate.nimble $PROJECT_NAME.nimble
