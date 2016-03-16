while true; do
    read -p "yes or no?" yn
    case $yn in
        [Yy]* ) 
			# actions go here.
		    break;;
        [Nn]* ) 
			# actions go here.
			break;;
        * ) 
			# keep looping until there's and answer
			echo "Please answer yes or no.";;
    esac
done