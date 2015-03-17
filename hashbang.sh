-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

#!/bin/sh
<<\EOF
<!--
  Hey, you found the source code!

  That is a sign you hopefully know better than to blindly run unknown commands
  from the internet and/or are a curious person. We like you already.

  What this command will actually do, is set you up with a free "shell" account
  on one of our servers, that you can use as you see fit. It will also set you
  up with email, IRC, and other things on your shell, so you can keep in touch
  and learn/make awesome things with us.

  Don't trust us? Good! You probably don't know us (yet) so you shouldn't.

  To help address this we GPG sign this shell-setup script so you can verify
  it has not been changed by a third party before you run it by doing:

  > gpg --verify <(curl https://hashbang.sh)

  The safest method of running a script from a source you don't trust is to:

  Download locally over SSL
  > curl https://hashbang.sh >> hashbang.sh

  Verify integrty with GPG (If available)
  > gpg --recv-keys 0xD2C4C74D8FAA96F5
  > gpg --verify hashbang.sh

  Inspect source code
  > less hashbang.sh

  Run
  > chmod +x hashbang.sh
  > ./hashbang.sh

  As an advanced alternative you can bypass using this script and hit our user
  provisioning API directly with an SSH Public Key and desired username:

  > curl -d '{"user":"someuser","key":"'"$(cat ~/.ssh/id_rsa.pub)"'"}' -H 'Content-Type: application/json' https://hashbang.sh/user/create

  We look forward to seeing you on the other side.

- -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>&lrm;</title>
    <meta name="viewport" content="initial-scale = 1, maximum-scale=1, user-scalable = 0"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <meta name="HandheldFriendly" content="true"/>
    <meta name="MobileOptimized" content="320"/>
    <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
    <style type="text/css">
        * {
        text-indent:-9999px;
        -webkit-touch-callout: none;
        -webkit-user-select: none;
        -khtml-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }
      html {
        background:black;
        color:black;
      }
      body {
        display:block;
        position:fixed;
        top:50%;
        left:50%;
        margin-top:-160px;
        margin-left:-160px;
        width:320px;
        height:320px;
        color:#DDD;
        overflow:hidden;
      }
      h1 {
        text-indent:0px;
        font-family: 'Montserrat', cursive;
        position:absolute;
        top:-50px;
        left:10px;
        right:0px;
        line-height:0px;
        font-size:280px;
      }
      a {
        color:white;
        text-decoration:none;
      }
      code {
        text-indent:0px;
        display:block;
        position:absolute;
        bottom:0px;
        left:0px;
        right:0px;
        text-align:center;
        font-size:20px;
      }
    </style>
  </head>
  <body>
    <script>
      window.location="#!"
      var link = document.createElement("link");
      link.type = "image/png";
      link.rel = "icon";
      link.href = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQAAAAA3iMLMAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAd2KE6QAAAAYSURBVAjXY2CAAck+EKp/B0II9gMoGwYA4+MJkeae/NUAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTQtMDUtMTdUMTM6MzI6MTMtMDQ6MDB7pieOAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE0LTA1LTE3VDEzOjMxOjQ4LTA0OjAwqyt+rwAAAABJRU5ErkJggg==";
      document.getElementsByTagName("head")[0].appendChild(link);
    </script>
    <h1>#!</h1>
    <a href="view-source:https://hashbang.sh"><code>sh <(curl hashbang.sh)</code></a>
  </body>
</html>
<!--
EOF
#!/bin/sh
# This script first and foremost attempts to be POSIX compliant.
# Secondly, it attempts to be compatible with as many shell implementations as
# possible to provide an easy gateway for new users.

# If we're using bash, we do this
if [ "x$BASH" != "x" ]; then
	shopt -s extglob
	set -o posix
fi

checkutil() {
	printf " * Checking for $1..."
	which $1 >/dev/null
	if [ $? -eq 0 ]; then
		printf "ok!\n";
		return 0;
	else
		printf "not found!"
		return 1
	fi
}

# This function can be called with two parameters:
#
# First is obligatory, and is the "question posed".
# For instance, one may ask "is pizza your favorite meal?", to which the
# responder may answer Y (yes) or N (no).
#
# Second parameter is optional, and can be either Y or N.
# The reasoning behind this is to have a default answer to the question,
# resulting in the responder being able to simple press [enter] and skip
# pressing Y or N, giving the default answer instead.
ask() {
    while true; do
			prompt=""
			default=""

        if [ "${2}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question
				printf "%s [%s] " "$1" "$prompt"
        read REPLY

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

clear;
echo "   _  _    __  ";
echo " _| || |_ |  |  Welcome to #!. This network has three rules:";
echo "|_  __  _||  | ";
echo " _| || |_ |  |  1. When people need help, teach. Don't do it for them";
echo "|_  __  _||__|  2. Don't use our resources for closed source projects";
echo "  |_||_|  (__)  3. Be excellent to each other";
echo "               ";
echo " We are a diverse community of people who love teaching, and learning.";
echo " Putting a #! at the beginning of a \"script\" style program tells a ";
echo " computer that it needs to \"do something\" or \"execute\" this file.";
echo " Likewise, we are a community of people that like to \"do stuff\".";
echo " ";
echo " If you like technology, and you want to learn to write your first";
echo " program, learn to use Linux, or even take on interesting challenges";
echo " with some of the best in the industry, you are in the right place.";
echo "";
echo " The following will set you up with a \"shell\" account on one of our";
echo " shared systems. From here you can run IRC chat clients to talk to us,";
echo " access to personal file storage and web hosting, and a wide range of";
echo " development tools. ";
echo " ";
echo " Everything should work perfectly, unless it doesn't";
echo " ";
echo " Please report any issues here: ";
echo "   -> https://github.com/hashbang/hashbang.sh/issues/";
echo " ";
printf " If you agree with the above and wish to continue, hit [Enter] ";
read _
clear

echo " ";
echo " ";
echo " -------------------------------------------------------------------- ";
echo " ";

echo " First, your system must be properly configured with the required";
echo " utilities and executables.";
echo " We will perform a short check for those now.";
echo " NOTE: If you see this message, it is likely because something is";
echo " not installed. Check the list below, and install any";
echo " missing applications.";

checkutil expr || exit 1
( checkutil ssh-keygen && checkutil ssh ) || exit 1
( checkutil curl || checkutil busybox ) || exit 1

clear;

echo " ";
echo " ";
echo " -------------------------------------------------------------------- ";
echo " ";


echo " To create your account we first need a username.";
echo " ";
echo " A valid username must:";
echo "  * be between between 1-31 characters long";
echo "  * consist of only 0-9 and a-z (lowercase only)";
echo "  * begin with a letter";
echo " ";
echo " Traditional unix usernames are first initial, optional middle initial,";
echo " and the first 6 characters of the last name, but feel free to use ";
echo " whatever you want";
echo " ";

while [ "x$username" = "x" ]; do
    printf " Username: ";
    read input;
    if echo "$input" | grep -E "^[a-z][a-z0-9]{0,30}$" >/dev/null; then
        username=$input
    else
        echo " ";
        echo " \"$input\" is not a valid username."
        echo " Please read the instructions and try again"
        echo " ";
    fi
done

echo " ";
echo " -------------------------------------------------------------------- ";
echo " ";
echo " Now we will need an SSH Public Key."
echo " ";
echo " SSH Keys are a type of public/private key system that let you identify ";
echo " yourself to systems like this one without ever sending your password ";
echo " over the internet, and thus by nature we won't even know what it is";
echo " ";

for keytype in id_rsa id_dsa id_ecdsa id_ed25519; do
    if [ -e ~/.ssh/$keytype.pub  ]; then
        if ask " We found a public key in [ ~/.ssh/$keytype.pub ]. Use this key?" Y; then
            keyfile="~/.ssh/$keytype.pub"
            key=$(cat ~/.ssh/$keytype.pub)
            break
        fi
    fi
done

if [ "x$key" = "x" ]; then
    if ask " Do you want us to generate a key for you?" Y; then
        ssh-keygen -t rsa -C "#! $username"
        keyfile="~/.ssh/id_rsa.pub"
        key=$(cat ~/.ssh/id_rsa.pub)
    fi
fi



while [ "x$key" = "x" ]; do
    echo " ";
    echo " Please enter path to SSH Public Key: ";
    read keyfile
    if [ -f $keyfile ] ; then
        ssh-keygen -l -f $keyfile > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            key=$(cat $keyfile)
        else
            echo " ";
            echo " \"$keyfile\" is not a valid SSH Public Key";
        fi
    else
       echo " ";
       echo " \"$keyfile\" does not exist";
    fi
done

# Insert functions to allow user to select from multiple hosts here
# hardcoding all users to va1 for now
host="va1"

if [ "x$key" != "x" -a "x$username" != "x" ]; then
    echo " ";
    echo " -------------------------------------------------------------------- ";
    echo " ";
    echo " We are going to create an account with the following information";
    echo " ";
    echo " Username: $username";
    echo " Public Key: $keyfile";
    echo " Host: $host";
    echo " ";
    if ask " Does this look correct?" Y ; then
        echo " ";
        echo " Creating your account...";
        echo " ";

	if curl -f -H "Content-Type: application/json" \
        -d "{\"user\":\"$username\",\"key\":\"$key\",\"host\":\"$host\"}" \
        https://hashbang.sh/user/create; then
            echo " ";
            echo " Account Created!"
            echo " ";
        else
            echo " ";
            echo " Account creation failed.";
            echo " Something went awfully wrong and we couldn't create an account for you.";
            echo " If you think this is a bug, please report it to ";
            echo " -> https://github.com/hashbang/hashbang.sh/issues/";
            echo " ";
            echo " The installer will not continue from here...";
            echo " ";
            exit 1
        fi

        if ask " Would you like an alias (shortcut) added to your .ssh/config?" Y ; then
            printf "\nHost hashbang\n  HostName ${host}.hashbang.sh\n  User %s\n  IdentityFile %s\n" \
							"$username" "$keyfile" \
            >> ~/.ssh/config
            echo " You can now connect any time by entering the command:";
            echo " ";
            echo " > ssh hashbang";
        else
            echo " You can now connect any time by entering the command:";
            echo " ";
            echo " > ssh ${username}@${host}.hashbang.sh";
        fi

        echo " ";
    fi

    if ask " Do you want us to log you in now?" Y; then
        ssh ${username}@${host}.hashbang.sh
    fi
fi
# exit [n]. if [n] is not specified, then exit shall use the return code of the
# last command.
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVBUEaAAoJENLEx02Pqpb1t8MQAILYt9PTMyWC5rqd9E78eCA6
wlv/LLDdbNdLfSyWxGZCQbPzxmb1q0rgQdstm111samUvqQWbHNEVnjI8Ms4AmaI
SmYXgF3e491rWGtf6DBhcoGAHrr1ClmdJHUqgyamdd++mHrWLjSh+WtzbsHrRPTy
xZ2egiJKVydFktsSxQvDk4ruZaRfBDwmSuZ/JGK60oIb5U8dWN3LV9R6gAucAVNp
TsDqJajh9yl/vaB5ebhFrzJaWmSUT/FEU5Ulv48AGJjmSonGZR3fCICaVoKTAqhM
5SMjD4d9CChKRg3K1JV+SgWBydj59bPMiw2+7tu4RU6S6o+tsTQlMs26E/qwZ7qT
aN65KXVvZX9YGTxjo4V/qAQWlcWHgzJFmzHiQrDv2BUYKU822pJ/d88oGo7I13ZG
DeMXexnKp66W6Bl591zDYqlTGiF8NpZrp7VE2SpkT0BqnuKtN81KVGCYgwA4TOf7
VlEuJRb/Plz1sWcNB9CpYxS/gh886l2lEIa20T+YYu+6Bos9olcR3HA6RiEHC2FE
Fk2z7b67ocprWp9euiMMEBL0/Cx9jBdDdyhM8MQ75YImRKwTnPHdpq5CcJJ5Quwx
c13aIemWlgQU30hQmISiKsU70q0Z+ax3GmdSsdfXRiyRIlqGAbS+GPU9xatp44JA
WxDkrEseYOPiDRlzEh3K
=OvXQ
-----END PGP SIGNATURE-----
