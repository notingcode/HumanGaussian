# Download official SMPL-X models from MPG website
urle () { [[ "${1}" ]] || return 1; local LANG=C i x; for (( i = 0; i < ${#1}; i++ )); do x="${1:i:1}"; [[ "${x}" == [a-zA-Z0-9.~-] ]] && echo -n "${x}" || printf '%%%02X' "'${x}"; done; echo; }

read -p "Username (email):" username
read -p "Password:" -s password

username=$(urle $username)
password=$(urle $password)

mkdir -p dataset/models/smplx
wget --post-data "username=$username&password=$password" 'https://download.is.tue.mpg.de/download.php?domain=smplx&sfile=models_smplx_v1_1.zip' -O 'dataset/smplx.zip' --no-check-certificate --continue
unzip -j dataset/smplx.zip "models/smplx/*" -d dataset/models/smplx

# Download Texture-Structure Joint Model
gdown --fuzzy 'https://drive.google.com/file/d/1YB9wKFoB1dumFUsVkHbSmgvI-4SD0kjo/view?usp=sharing' -O 'dataset/texture_structure_joint.zip'
unzip dataset/texture_structure_joint.zip -d dataset/models

rm dataset/smplx.zip dataset/texture_structure_joint.zip