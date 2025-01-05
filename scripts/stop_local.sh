#!/bin/sh

init_pwd_dir_name=$(basename "$PWD")
init_pwd_dir=$(pwd)
echo "Current directory name: $init_pwd_dir_name"

service_dirs=("auth-service" "payment-service")

for dir in "${service_dirs[@]}"
do
    echo "Switching current directory to: $dir"
    cd $dir
    echo "Stopping $dir service"
    make stop
    make_exit_status=$?
    if [ $make_exit_status -ne 0 ]; then
        echo "Failed to start $dir service"
        exit $make_exit_status
    fi
    echo "Switching to initial PWD: $init_pwd_dir_name"
    cd $init_pwd_dir
done

echo "Stopping all shared services..."
docker compose down