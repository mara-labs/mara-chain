package types

import (
	"math/big"

	sdk "github.com/cosmos/cosmos-sdk/types"
)

const (
	// AttoMara defines the default coin denomination used in Mara in:
	//
	// - Staking parameters: denomination used as stake in the dPoS chain
	// - Mint parameters: denomination minted due to fee distribution rewards
	// - Governance parameters: denomination used for spam prevention in proposal deposits
	// - Crisis parameters: constant fee denomination used for spam prevention to check broken invariant
	// - EVM parameters: denomination used for running EVM state transitions in Ethermint.
	AttoMara string = "amara"

	// BaseDenomUnit defines the base denomination unit for maras.
	// 1 mara = 1x10^{BaseDenomUnit} amara
	BaseDenomUnit = 18

	// DefaultGasPrice is default gas price for evm transactions
	DefaultGasPrice = 20
)

// PowerReduction defines the default power reduction value for staking
var PowerReduction = sdk.NewIntFromBigInt(new(big.Int).Exp(big.NewInt(10), big.NewInt(BaseDenomUnit), nil))

// NewMaraCoin is a utility function that returns an "amara" coin with the given sdk.Int amount.
// The function will panic if the provided amount is negative.
func NewMaraCoin(amount sdk.Int) sdk.Coin {
	return sdk.NewCoin(AttoMara, amount)
}

// NewMaraDecCoin is a utility function that returns an "amara" decimal coin with the given sdk.Int amount.
// The function will panic if the provided amount is negative.
func NewMaraDecCoin(amount sdk.Int) sdk.DecCoin {
	return sdk.NewDecCoin(AttoMara, amount)
}

// NewMaraCoinInt64 is a utility function that returns an "amara" coin with the given int64 amount.
// The function will panic if the provided amount is negative.
func NewMaraCoinInt64(amount int64) sdk.Coin {
	return sdk.NewInt64Coin(AttoMara, amount)
}
