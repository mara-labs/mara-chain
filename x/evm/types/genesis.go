package types

import "github.com/evmos/ethermint/x/evm/types"

// DefaultGenesisState sets default evm genesis state with empty accounts and default params and
// chain config values.
func DefaultGenesisState() *types.GenesisState {
	return &types.GenesisState{
		Accounts: []types.GenesisAccount{},
		Params:   DefaultParams(),
	}
}
