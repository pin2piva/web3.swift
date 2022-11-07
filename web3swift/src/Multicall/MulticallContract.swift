//
//  web3.swift
//  Copyright © 2022 Argent Labs Limited. All rights reserved.
//

import BigInt
import Foundation

extension Multicall {
    public enum Contract {

        static let goerliAddress: EthereumAddress = "0x77dCa2C955b15e9dE4dbBCf1246B4B85b651e50e"
        static let ropstenAddress: EthereumAddress = "0x604D19Ba889A223693B0E78bC1269760B291b9Df"
        static let rinkebyAddress: EthereumAddress = "0xF20A5837Eb2D9F1F7cdf9D635f3Bc68C47B8B8fF"
        static let mainnetAddress: EthereumAddress = "0xF34D2Cb31175a51B23fb6e08cA06d7208FaD379F"
        static let bscDataseedAddress: EthereumAddress = "0x41263cba59eb80dc200f3e2544eda4ed6a90e76c"
        static let polygonRpcAddress: EthereumAddress = "0x11ce4B23bD875D7F5C6a31084f55fDe1e9A87507"
        static let avalanceCChainAddress: EthereumAddress = "0xa00FB557AA68d2e98A830642DBbFA534E8512E5f"

        public static func registryAddress(for network: EthereumNetwork) -> EthereumAddress? {
            switch network {
            case .ropsten:
                return Self.ropstenAddress
            case .rinkeby:
                return Self.rinkebyAddress
            case .mainnet:
                return Self.mainnetAddress
            case .goerli:
                return Self.goerliAddress
            case .custom(let id):
                switch id {
                case "56":
                    return Self.bscDataseedAddress
                case "137":
                    return Self.polygonRpcAddress
                case "43114":
                    return Self.avalanceCChainAddress
                default:
                    return nil
                }
            default:
                return nil
            }
        }

        public enum Functions {
            public struct aggregate: ABIFunction {
                public static let name = "aggregate"
                public let gasPrice: BigUInt?
                public let gasLimit: BigUInt?
                public var contract: EthereumAddress
                public let from: EthereumAddress?
                public let calls: [Call]

                public init(contract: EthereumAddress,
                            from: EthereumAddress? = nil,
                            gasPrice: BigUInt? = nil,
                            gasLimit: BigUInt? = nil,
                            calls: [Call]) {
                    self.contract = contract
                    self.from = from
                    self.gasPrice = gasPrice
                    self.gasLimit = gasLimit
                    self.calls = calls
                }

                public func encode(to encoder: ABIFunctionEncoder) throws {
                    try encoder.encode(calls)
                }
            }
        }
    }
}
