package crypto

import "github.com/nknorg/nkn/v2/crypto/ed25519"

func GetPublicKeyFromPrivateKey(privateKey []byte) []byte {
	return ed25519.GetPublicKeyFromPrivateKey(privateKey)
}

func GetPrivateKeyFromSeed(seed []byte) []byte {
	return ed25519.GetPrivateKeyFromSeed(seed)
}

func GetSeedFromPrivateKey(priKey []byte) []byte {
	return ed25519.GetSeedFromPrivateKey(priKey)
}

func Sign(privateKey, data []byte) ([]byte, error) {
	pk := make([]byte, len(privateKey))
	copy(pk, privateKey)
	d := make([]byte, len(data))
	copy(d, data)
	return ed25519.Sign(pk, d)
}

func Verify(publicKey, data, signature []byte) error {
	return ed25519.Verify(publicKey, data, signature)
}
