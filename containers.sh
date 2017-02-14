#! /bin/bash

function usage() {
	echo "Usage: $0 [-n <number_of_participants>] [-t <delay_time>] [-s <messages_size>] [-m <number_of_participants_with_message>] [-l <log_folder>]";
	exit 2
}

# Handle options for usage
while getopts ":n:d:t:s:m:l:" o;
do
	case "${o}" in
		n)
			participants=${OPTARG}
			;;
		t)
			delay=${OPTARG}
			;;
		s)
			message_size=${OPTARG}
			;;
		m)
			total_messages=${OPTARG}
			;;
		l)
			log_folder=${OPTARG}
			;;
		*)
			usage
			;;
	esac
done

# Abort if not present some of the options
if [ -z "${participants}" ] || [ -z "${delay}" ] || [ -z "${message_size}" ] || [ -z "${total_messages}" ]|| [ -z "${log_folder}" ]
then
	usage
fi

# Create Docker images
docker pull camilog/participant-node &>/dev/null
docker pull camilog/directory-node &>/dev/null

# Set directory node IP address (as the last container to be run)
subnet="172.18.0."
host=$((2 + ${participants}))
directory_ip=$subnet$host

# Configure the message and run every one of the participant nodes
for (( i=1; i<=${total_messages}; i++ ))
do
	msg=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $message_size | head -n 1)
	docker run --name p$i --rm --env MSG=$msg --env DIRECTORY=$directory_ip camilog/participant-node 1>$log_folder/$i.csv &
done
limit=$((1 + ${total_messages}))
for (( i=${limit}; i<=${participants}; i++ ))
do
	docker run --name p$i --rm --env MSG='' --env DIRECTORY=$directory_ip camilog/participant-node 2>/dev/null 1>$log_folder/$i.csv &
done
last_pid=$!

sleep 5

# Configure and run pumba, in order to manage network parameters
./pumba netem --duration ${participants}m delay -t $delay -j 0 -c 0 re2:^p &>/dev/null &
pumba_pid=$!

# Wait 5 seconds and then run directory node
sleep 20
docker run --name dir --rm --env N=$participants --env MSG_SIZE=$message_size --env PAD_LENGTH=10 --env NON_PROB=true camilog/directory-node &>/dev/null &

# Wait last participant node and kill pumba process
wait $last_pid
kill $pumba_pid
