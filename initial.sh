#!/bin/bash
cat "" > database_content/user_content.sql
echo -n "Enter user name and press [ENTER]: "
read name
if [ ${#name} -lt 3 ]; then
    echo "Error: Name is too short"
    exit 0
fi

echo -n "Enter user password and press [ENTER]: "
read -s password
printf "\n"
if [ ${#password} -lt 5 ]; then
    echo "Error: Password is shorter than 5 digits"
    exit 0
fi

echo -n "(Optional) Enter user email and press [ENTER]: "
read emailaddress
if [ -z "$emailaddress" ]; then
    emailaddress=""
fi

saltvalue=$(date +%s | sha256sum | awk '{ print $1; }')

cat <<EOF >> database_content/user_content.sql
START TRANSACTION;
INSERT INTO \`WUser\` (\`ID\`, \`name\`, \`pw\`, \`salt\`, \`token\`, \`mail\`) VALUES
(0, '$name', '$password', '$saltvalue', 'ABC', '$emailaddress');
COMMIT;
EOF
