set dotenv-load
set export

# deployments
deploy_faucet JSON_RPC_URL SENDER:
    forge script script/Faucet.s.sol:FaucetScript --rpc-url $JSON_RPC_URL --sender $SENDER --broadcast --ffi -vvvv

# deploy to Ethereum Sepolia
deploy:
    echo "Deploying contracts to Ethereum Sepolia"
    NETWORK_ID=$CHAIN_ID_ETHEREUM_SEPOLIA MNEMONIC=$MNEMONIC_TESTNET just deploy_faucet $RPC_URL_ETHEREUM_SEPOLIA $SENDER_TESTNET

# forge
compile: 
    echo "Compiling contracts"
    forge build

# testing
test:
    echo "Running tests"
    forge test

test_coverage:
    forge coverage --report lcov 
    lcov --remove ./lcov.info --output-file ./lcov.info 'script' 'DeployerUtils.sol' 'DeploymentUtils.sol'
    genhtml lcov.info -o coverage --branch-coverage --ignore-errors category