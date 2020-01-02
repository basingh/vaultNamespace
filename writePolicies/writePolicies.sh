# Create edu-admin policy under 'education' namespace
vault policy write -namespace=education edu-admin edu-admin.hcl

# Create training-admin policy under 'education/training' namespace
vault policy write -namespace=education/training training-admin training-admin.hcl