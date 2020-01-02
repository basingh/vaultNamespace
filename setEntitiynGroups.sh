#In the education namespace, 
#create an entity, Bob Smith with edu-admin policy attached. 
#Add a userpass user, bob as an entity alias. 
#By default, Bob Smith has no visibility into the education/training namespace since the bob user was defined in 
#the education namespace.

#You are going to create an internal group named, Training Admin in the education/training namespace
#with training-admin policy attached. To grant the training-admin policy for bob, 
#add the Bob Smith entity to the Training Admin group as a member entity.

# First, you need to enable userpass auth method
vault auth enable -namespace=education userpass

# Create a user 'bob'
vault write -namespace=education \
        auth/userpass/users/bob password="training"

# Create an entity for Bob Smith with 'edu-admin' policy attached
# Save the generated entity ID in entity_id.txt file
vault write -namespace=education -format=json identity/entity name="Bob Smith" \
        policies="edu-admin" | jq -r ".data.id" > entity_id.txt

# Get the mount accessor for userpass auth method and save it in accessor.txt file
vault auth list -namespace=education -format=json \
        | jq -r '.["userpass/"].accessor' > accessor.txt

# Create an entity alias for Bob Smith to attach 'bob'
vault write -namespace=education identity/entity-alias name="bob" \
        canonical_id=$(cat entity_id.txt) mount_accessor=$(cat accessor.txt)

# Create a group, "Training Admin" in education/training namespace with Bob Smith entity as its member
vault write -namespace=education/training identity/group \
        name="Training Admin" policies="training-admin" \
        member_entity_ids=$(cat entity_id.txt)